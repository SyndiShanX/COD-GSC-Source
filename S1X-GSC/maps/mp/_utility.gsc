/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\_utility.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

MAX_VEHICLES = 8;

LIGHTWEIGHT_SCALAR = 1.07;

ATTACHMAP_TABLE = "mp/attachmentmap.csv";
ATTACHMAP_COL_CLASS_OR_WEAP_NAME = 0;
ATTACHMAP_ROW_ATTACH_BASE_NAME = 0;

ATTACHMENT_TABLE = "mp/attachmentTable.csv";
ATTACHMENT_COL_INDEX = 0;
ATTACHMENT_COL_GROUP = 1;
ATTACHMENT_COL_REF_UNIQUE = 3;
ATTACHMENT_COL_REF_BASE = 4;
ATTACHMENT_COL_PERK = 8;

exploder_sound() {
  if(isDefined(self.script_delay)) {
    wait self.script_delay;
  }

  self playSound(level.scr_sound[self.script_sound]);
}

_beginLocationSelection(streakName, selectorType, directionality, size) {
  self BeginLocationSelection(selectorType, directionality, size);
  self SetClientOmnvar("ui_map_location_selector", 1);
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
  self thread endSelectionOHostMigration();
}

stopLocationSelection(disconnected, reason) {
  if(!isDefined(reason)) {
    reason = "generic";
  }

  if(!disconnected) {
    self SetClientOmnvar("ui_map_location_selector", 0);
    self setblurforplayer(0, 0.3);
    self endLocationSelection();
    self.selectingLocation = undefined;
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

endSelectionOnAction(waitfor, numActions) {
  self endon("stop_location_selection");
  if(!isDefined(numActions)) {
    numActions = 1;
  }
  for(; numActions > 0; numActions--) {
    self waittill(waitfor);
  }
  self thread stopLocationSelection((waitfor == "disconnect"), waitfor);
}

endSelectionOnEndGame() {
  self endon("stop_location_selection");
  level waittill("game_ended");
  self thread stopLocationSelection(false, "end_game");
}

endSelectionOHostMigration() {
  self endon("stop_location_selection");
  level waittill("host_migration_begin");
  self thread stopLocationSelection(false, "hostmigrate");
}

isAttachment(attachmentName) {
  attachment = tableLookup(ATTACHMENT_TABLE, ATTACHMENT_COL_REF_UNIQUE, attachmentName, ATTACHMENT_COL_INDEX);

  if(isDefined(attachment) && attachment != "") {
    return true;
  } else {
    return false;
  }
}

getAttachmentType(attachmentName) {
  attachmentType = tableLookup(ATTACHMENT_TABLE, ATTACHMENT_COL_REF_UNIQUE, attachmentName, ATTACHMENT_COL_GROUP);

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
  } else {
    if(!isDefined(param2)) {}
    assertex(!isDefined(param3), "Delaythread does not support vars after undefined.");
    assertex(!isDefined(param4), "Delaythread does not support vars after undefined.");
    assertex(!isDefined(param5), "Delaythread does not support vars after undefined.");
    thread[[func]](param1);
  } else {
    if(!isDefined(param3)) {}
    assertex(!isDefined(param4), "Delaythread does not support vars after undefined.");
    assertex(!isDefined(param5), "Delaythread does not support vars after undefined.");
    thread[[func]](param1, param2);
  } else {
    if(!isDefined(param4)) {}
    assertex(!isDefined(param5), "Delaythread does not support vars after undefined.");
    thread[[func]](param1, param2, param3);
  } else {
    if(!isDefined(param5)) {}
    thread[[func]](param1, param2, param3, param4);
  } else {
    thread[[func]](param1, param2, param3, param4, param5);
  }
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

  if(besttracefraction == 1) {
    besttraceposition = self.origin;
  }

  temp = spawnStruct();
  temp.origin = besttraceposition;
  temp.angles = orientToNormal(trace["normal"]);
  return temp;
}

orientToNormal(normal) {
  hor_normal = (normal[0], normal[1], 0);
  hor_length = length(hor_normal);

  if(!hor_length) {
    return (0, 0, 0);
  }

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
    if(isDefined(level.players[0])) {
      level.players[0] playLocalSound(sound);
    }
  } else {
    if(isDefined(team)) {
      if(isDefined(excludeList)) {
        for(i = 0; i < level.players.size; i++) {
          player = level.players[i];

          if(player isSplitscreenPlayer() && !player isSplitscreenPlayerPrimary()) {
            continue;
          }

          if(isDefined(player.pers["team"]) && (player.pers["team"] == team) && !isExcluded(player, excludeList)) {
            player playLocalSound(sound);
          }
        }
      } else {
        for(i = 0; i < level.players.size; i++) {
          player = level.players[i];

          if(player isSplitscreenPlayer() && !player isSplitscreenPlayerPrimary()) {
            continue;
          }

          if(isDefined(player.pers["team"]) && (player.pers["team"] == team)) {
            player playLocalSound(sound);
          }
        }
      }
    } else {
      if(isDefined(excludeList)) {
        for(i = 0; i < level.players.size; i++) {
          player = level.players[i];

          if(player isSplitscreenPlayer() && !player isSplitscreenPlayerPrimary()) {
            continue;
          }

          if(!isExcluded(player, excludeList)) {
            player playLocalSound(sound);
          }
        }
      } else {
        for(i = 0; i < level.players.size; i++) {
          player = level.players[i];

          if(player isSplitscreenPlayer() && !player isSplitscreenPlayerPrimary()) {
            continue;
          }

          player playLocalSound(sound);
        }
      }
    }
  }
}

playLoopSoundToPlayers(alias, offset, players) {
  if(!SoundExists(alias)) {
    println("Warning: playLoopSoundToPlayers() alias doesn't exist: " + alias);
    return;
  }

  org = spawn("script_origin", (0, 0, 0));
  org endon("death");
  thread delete_on_death(org);

  if(isDefined(players)) {
    org Hide();
    foreach(player in players) {
      org ShowToPlayer(player);
    }
  }
  if(isDefined(offset)) {
    org.origin = self.origin + offset;
    org.angles = self.angles;
    org linktosynchronizedparent(self);
  } else {
    org.origin = self.origin;
    org.angles = self.angles;
    org linktosynchronizedparent(self);
  }

  org playLoopSound(alias);

  self waittill("stop sound" + alias);
  org StopLoopSound(alias);
  org Delete();
}

sortLowerMessages() {
  for(i = 1; i < self.lowerMessages.size; i++) {
    message = self.lowerMessages[i];
    priority = message.priority;
    for(j = i - 1; j >= 0 && priority > self.lowerMessages[j].priority; j--) {
      self.lowerMessages[j + 1] = self.lowerMessages[j];
    }
    self.lowerMessages[j + 1] = message;
  }
}

addLowerMessage(name, text, time, priority, showTimer, shouldFade, fadeToAlpha, fadeToAlphaTime, hideWhenInDemo) {
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
        if(isDefined(self.lowerMessages[j])) {
          self.lowerMessages[j - 1] = self.lowerMessages[j];
        }
      }

      self.lowerMessages[self.lowerMessages.size - 1] = undefined;
    }

    sortLowerMessages();
  }
}

getLowerMessage() {
  return self.lowerMessages[0];
}

setLowerMessage(name, text, time, priority, showTimer, shouldFade, fadeToAlpha, fadeToAlphaTime, hideWhenInDemo) {
  if(!isDefined(priority)) {
    priority = 1;
  }

  if(!isDefined(time)) {
    time = 0;
  }

  if(!isDefined(showTimer)) {
    showTimer = false;
  }

  if(!isDefined(shouldFade)) {
    shouldFade = false;
  }

  if(!isDefined(fadeToAlpha)) {
    fadeToAlpha = 0.85;
  }

  if(!isDefined(fadeToAlphaTime)) {
    fadeToAlphaTime = 3.0;
  }

  if(!isDefined(hideWhenInDemo)) {
    hideWhenInDemo = false;
  }

  self addLowerMessage(name, text, time, priority, showTimer, shouldFade, fadeToAlpha, fadeToAlphaTime, hideWhenInDemo);
  self updateLowerMessage();
}

updateLowerMessage() {
  if(!isDefined(self.lowerMessage)) {
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
  for(i = 0; i < self.lowerMessages.size; i++) {
    self.lowerMessages[i] = undefined;
  }

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
    if((isDefined(player.pers["team"])) && (player.pers["team"] == team)) {
      player iprintlnbold(text);
    }
  }
}

printBoldOnTeamArg(text, team, arg) {
  assert(isDefined(level.players));
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if((isDefined(player.pers["team"])) && (player.pers["team"] == team)) {
      player iprintlnbold(text, arg);
    }
  }
}

printOnTeamArg(text, team, arg) {
  assert(isDefined(level.players));
  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];
    if((isDefined(player.pers["team"])) && (player.pers["team"] == team)) {
      player iprintln(text, arg);
    }
  }
}

printOnPlayers(text, team) {
  players = level.players;
  for(i = 0; i < players.size; i++) {
    if(isDefined(team)) {
      if((isDefined(players[i].pers["team"])) && (players[i].pers["team"] == team)) {
        players[i] iprintln(text);
      }
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
        if(playerteam == team && isDefined(printFriendly)) {
          player iprintln(printFriendly, printarg);
        } else if(playerteam == otherteam && isDefined(printEnemy)) {
          player iprintln(printEnemy, printarg);
        }
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
            if(isDefined(printFriendly)) {
              player iprintln(printFriendly, printarg);
            }
            player playLocalSound(soundFriendly);
          } else if(playerteam == otherteam) {
            if(isDefined(printEnemy)) {
              player iprintln(printEnemy, printarg);
            }
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
            if(isDefined(printFriendly)) {
              player iprintln(printFriendly, printarg);
            }
            player playLocalSound(soundFriendly);
          } else if(playerteam == otherteam) {
            if(isDefined(printEnemy)) {
              player iprintln(printEnemy, printarg);
            }
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

  if(value > maxVal) {
    value = maxVal;
  } else if(value < minVal) {
    value = minVal;
  } else {
    return value;
  }

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

  if(value > maxVal) {
    value = maxVal;
  } else if(value < minVal) {
    value = minVal;
  } else {
    return value;
  }

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

  if(team == "allies") {
    return "axis";
  } else if(team == "axis") {
    return "allies";
  } else {
    return "none";
  }

  assertMsg("getOtherTeam: invalid team " + team);
}

wait_endon(waitTime, endOnString, endonString2, endonString3) {
  self endon(endOnString);
  if(isDefined(endonString2)) {
    self endon(endonString2);
  }
  if(isDefined(endonString3)) {
    self endon(endonString3);
  }

  wait(waitTime);
}

initPersStat(dataName) {
  if(!isDefined(self.pers[dataName])) {
    self.pers[dataName] = 0;
  }
}

getPersStat(dataName) {
  return self.pers[dataName];
}

incPersStat(dataName, increment) {
  if(isDefined(self) && isDefined(self.pers) && isDefined(self.pers[dataName])) {
    self.pers[dataName] += increment;
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
    if(!isDefined(defaultvalue)) {
      defaultvalue = 0;
    }

    self.stats["stats_" + ref] = spawnStruct();
    self.stats["stats_" + ref].value = defaultvalue;

    if(self rankingEnabled()) {
      self setCommonPlayerData("round", "awards", ref, 0);
    }
  }
}

incPlayerStat(ref, increment) {
  if(IsAgent(self)) {
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

  if(newvalue > currentvalue) {
    self setPlayerStat(ref, newvalue);
  }
}

setPlayerStatIfLower(ref, newvalue) {
  currentvalue = self getPlayerStat(ref);

  if(newvalue < currentvalue) {
    self setPlayerStat(ref, newvalue);
  }
}

updatePersRatio(ratio, num, denom) {
  if(!self rankingEnabled()) {
    return;
  }

  numValue = self maps\mp\gametypes\_persistence::statGet(num);
  denomValue = self maps\mp\gametypes\_persistence::statGet(denom);
  if(denomValue == 0) {
    denomValue = 1;
  }

  self maps\mp\gametypes\_persistence::statSet(ratio, int((numValue * 1000) / denomValue));
}

updatePersRatioBuffered(ratio, num, denom) {
  if(!self rankingEnabled()) {
    return;
  }

  numValue = self maps\mp\gametypes\_persistence::statGetBuffered(num);
  denomValue = self maps\mp\gametypes\_persistence::statGetBuffered(denom);
  if(denomValue == 0) {
    denomValue = 1;
  }

  self maps\mp\gametypes\_persistence::statSetBuffered(ratio, int((numValue * 1000) / denomValue));
}

WaitTillSlowProcessAllowed(allowLoop) {
  if(level.lastSlowProcessFrame == gettime()) {
    if(isDefined(allowLoop) && allowLoop) {
      while(level.lastSlowProcessFrame == getTime()) {
        wait(0.05);
      }
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

waitForTimeOrNotifies(time, notifies) {
  if(isDefined(notifies)) {
    foreach(notify_name in notifies) {
      self endon(notify_name);
    }
  }

  if(isDefined(time) && time > 0) {
    wait time;
  }
}

isExcluded(entity, entityList) {
  for(index = 0; index < entityList.size; index++) {
    if(entity == entityList[index]) {
      return true;
    }
  }
  return false;
}

leaderDialog(dialog, team, group, excludeList, location) {
  if(isDefined(level.isZombieGame) && level.isZombieGame) {
    return;
  }

  assert(isDefined(level.players));

  if(dialog == "null") {
    return;
  }

  if(!isDefined(team)) {
    leaderDialogBothTeams(dialog, "allies", dialog, "axis", group, excludeList, location);
    return;
  }

  if(isDefined(excludeList)) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      if((isDefined(player.pers["team"]) && (player.pers["team"] == team)) && !isExcluded(player, excludeList)) {
        if(player isSplitscreenPlayer() && (!player isSplitscreenPlayerPrimary() || player IsSplitscreenOtherPlayerEnemy())) {
          continue;
        }

        player leaderDialogOnPlayer(dialog, group, undefined, location);
      }
    }
  } else {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      if(isDefined(player.pers["team"]) && (player.pers["team"] == team)) {
        if(player isSplitscreenPlayer() && (!player isSplitscreenPlayerPrimary() || player IsSplitscreenOtherPlayerEnemy())) {
          continue;
        }

        player leaderDialogOnPlayer(dialog, group, undefined, location);
      }
    }
  }
}

leaderDialogBothTeams(dialog1, team1, dialog2, team2, group, excludeList, location) {
  if(isDefined(level.isZombieGame) && level.isZombieGame) {
    return;
  }

  assert(isDefined(level.players));

  if(level.splitscreen) {
    return;
  }

  if(level.splitscreen) {
    if(level.players.size) {
      level.players[0] leaderDialogOnPlayer(dialog1, group, undefined, location);
    }
    return;
  }

  if(isDefined(excludeList)) {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      team = player.pers["team"];

      if(!isDefined(team)) {
        continue;
      }

      if(isExcluded(player, excludeList)) {
        continue;
      }

      if(player isSplitscreenPlayer() && (!player isSplitscreenPlayerPrimary() || player IsSplitscreenOtherPlayerEnemy())) {
        continue;
      }

      if(team == team1) {
        player leaderDialogOnPlayer(dialog1, group, undefined, location);
      } else if(team == team2) {
        player leaderDialogOnPlayer(dialog2, group, undefined, location);
      }
    }
  } else {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      team = player.pers["team"];

      if(!isDefined(team)) {
        continue;
      }

      if(player isSplitscreenPlayer() && (!player isSplitscreenPlayerPrimary() || player IsSplitscreenOtherPlayerEnemy())) {
        continue;
      }

      if(team == team1) {
        player leaderDialogOnPlayer(dialog1, group, undefined, location);
      } else if(team == team2) {
        player leaderDialogOnPlayer(dialog2, group, undefined, location);
      }
    }
  }
}

leaderDialogOnPlayers(dialog, players, group, location) {
  if(isDefined(level.isZombieGame) && level.isZombieGame) {
    return;
  }

  foreach(player in players) {
    player leaderDialogOnPlayer(dialog, group, undefined, location);
  }
}

leaderDialogOnPlayer(dialog, group, groupOverride, location) {
  if(isDefined(level.isZombieGame) && level.isZombieGame) {
    return;
  }

  if(!isDefined(groupOverride)) {
    groupOverride = false;
  }

  team = self.pers["team"];

  if(isDefined(level.isHorde) && !self IsSplitscreenPlayerPrimary()) {
    return;
  }

  if(isDefined(level.announcerDisabled) && level.announcerDisabled) {
    return;
  }

  if(!isDefined(team)) {
    return;
  }

  if(team != "allies" && team != "axis") {
    return;
  }

  if(self isSplitscreenPlayer() && self IsSplitscreenOtherPlayerEnemy()) {
    return;
  }

  if(!isDefined(location)) {
    location = (0, 0, 0);
  }

  if(isDefined(group)) {
    if(self.leaderDialogGroup == group) {
      if(groupOverride) {
        if(self.leaderDialogActive != "") {
          self StopLocalSound(self.leaderDialogActive);
        }
        self thread leaderDialogOnPlayer_internal(dialog, team, location);
      }

      return;
    }

    hadGroupDialog = isDefined(self.leaderDialogGroups[group]);

    self.leaderDialogGroups[group] = dialog;
    dialog = group;

    if(hadGroupDialog) {
      return;
    }
  }

  if(self.leaderDialogActive == "") {
    self thread leaderDialogOnPlayer_internal(dialog, team, location);
  } else {
    self.leaderDialogQueue[self.leaderDialogQueue.size] = dialog;
    self.leaderDialogLocQueue[self.leaderDialogLocQueue.size] = location;
  }
}

leaderDialog_TryLockout(dialog, player) {
  lockoutTime = 2;
  if(isDefined(game["dialog"]["lockouts"][dialog])) {
    lockoutTime = game["dialog"]["lockouts"][dialog];
    if(lockoutTime == 0) {
      return;
    }
  }
  if(!isDefined(player.active_vo_lockouts)) {
    player.active_vo_lockouts = [];
  }
  player.active_vo_lockouts[dialog] = true;
  thread leaderDialog_LockoutClearDelayed(dialog, player, lockoutTime);
}

leaderDialog_LockoutClearDelayed(dialog, player, waittime) {
  player endon("disconnect");
  wait(waittime);
  player.active_vo_lockouts[dialog] = undefined;
}

leaderDialog_IsLockedout(dialog, player) {
  if(isDefined(player.active_vo_lockouts)) {
    if(isDefined(player.active_vo_lockouts[dialog])) {
      if(isDefined(player.active_vo_lockouts[dialog] == true)) {
        return true;
      }
    }
  }
  return false;
}

leaderDialogOnPlayer_internal(dialog, team, location) {
  self endon("disconnect");

  self notify("playLeaderDialogOnPlayer");
  self endon("playLeaderDialogOnPlayer");

  if(isDefined(self.leaderDialogGroups[dialog])) {
    group = dialog;
    dialog = self.leaderDialogGroups[group];
    self.leaderDialogGroups[group] = undefined;
    self.leaderDialogGroup = group;
  }

  if(!isDefined(game["dialog"][dialog])) {
    PrintLn("Dialog " + dialog + " was not defined in game[dialog] array.");
    return;
  }

  if(IsAI(self) && isDefined(level.bot_funcs) && isDefined(level.bot_funcs["leader_dialog"])) {
    self[[level.bot_funcs["leader_dialog"]]](dialog, location);
  }

  if(isSubStr(game["dialog"][dialog], "null")) {
    return;
  }

  if(isDefined(level.isHorde) && level.isHorde) {
    if(issubstr(dialog, "coop_gdn")) {
      alias = dialog;
    } else {
      alias = "AT_anr0_" + game["dialog"][dialog];
    }
  } else {
    alias = game["voice"][team] + game["dialog"][dialog];
  }

  if(SoundExists(alias)) {
    if(leaderDialog_IsLockedout(game["dialog"][dialog], self)) {
      return;
    }
    self.leaderDialogActive = alias;
    self playLocalAnnouncerSound(alias);
    leaderDialog_TryLockout(game["dialog"][dialog], self);
  } else {
    PrintLn("Announcer Line Missing: " + alias);
  }

  wait(2.0);
  self.leaderDialogLocalSound = "";

  self.leaderDialogActive = "";
  self.leaderDialogGroup = "";

  if(self.leaderDialogQueue.size > 0) {
    assert(self.leaderDialogQueue.size == self.leaderDialogLocQueue.size);

    nextDialog = self.leaderDialogQueue[0];
    nextLoc = self.leaderDialogLocQueue[0];

    for(i = 1; i < self.leaderDialogQueue.size; i++) {
      self.leaderDialogQueue[i - 1] = self.leaderDialogQueue[i];
    }
    for(i = 1; i < self.leaderDialogLocQueue.size; i++) {
      self.leaderDialogLocQueue[i - 1] = self.leaderDialogLocQueue[i];
    }
    self.leaderDialogQueue[i - 1] = undefined;
    self.leaderDialogLocQueue[i - 1] = undefined;

    self thread leaderDialogOnPlayer_internal(nextDialog, team, nextLoc);
  }
}

getNextRelevantDialog() {
  for(i = 0; i < self.leaderDialogQueue.size; i++) {
    if(IsSubStr(self.leaderDialogQueue[i], "losing")) {
      if(self.team == "allies") {
        if(isSubStr(level.axisCapturing, self.leaderDialogQueue[i])) {
          return self.leaderDialogQueue[i];
        } else {
          array_remove(self.leaderDialogQueue, self.leaderDialogQueue[i]);
        }
      } else {
        if(isSubStr(level.alliesCapturing, self.leaderDialogQueue[i])) {
          return self.leaderDialogQueue[i];
        } else {
          array_remove(self.leaderDialogQueue, self.leaderDialogQueue[i]);
        }
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

flushDialogOnPlayer() {
  self.leaderDialogGroups = [];
  self.leaderDialogQueue = [];
  self.leaderDialogActive = "";
  self.currentLeaderDialogGroup = "";
  self notify("flush_dialog");
}

flushGroupDialog(group) {
  foreach(player in level.players) {
    player flushGroupDialogOnPlayer(group);
  }
}

ArrayRemoveValue(array, value) {
  sourceIndex = 0;
  targetIndex = 0;

  while(sourceIndex < array.size) {
    if(array[sourceIndex] == value) {
      sourceIndex++;
    } else {
      if(sourceIndex != targetIndex) {
        array[targetIndex] = array[sourceIndex];
      }

      sourceIndex++;
      targetIndex++;
    }
  }

  while(targetIndex < array.size) {
    array[targetIndex] = undefined;
    targetIndex++;
  }
}

flushGroupDialogOnPlayer(group) {
  self.leaderDialogGroups[group] = undefined;
  ArrayRemoveValue(self.leaderDialogQueue, group);

  if(self.leaderDialogQueue.size == 0) {
    self flushDialogOnPlayer();
  }
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
    if(level.splitScreen) {
      self setclientdvar("cg_objectiveText", getObjectiveScoreText(self.pers["team"]));
    } else {
      self setclientdvar("cg_objectiveText", getObjectiveScoreText(self.pers["team"]), getWatchedDvar("scorelimit"));
    }
  } else {
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
  if(!isDefined(level.startTime) || !isDefined(level.discardTime)) {
    return 0;
  }

  if(level.timerStopped) {
    return (level.timerPauseTime - level.startTime) - level.discardTime;
  } else {
    return (gettime() - level.startTime) - level.discardTime;
  }
}

getUnpausedTimePassedRaw() {
  if(!isDefined(level.matchDurationStartTime)) {
    return 0;
  }

  return (gettime() - level.matchDurationStartTime);
}

getGameTimePassedMS() {
  gameLengthMS = GetMatchData("gameLengthSeconds") * 1000;
  gameLengthMS = gameLengthMS + getUnpausedTimePassedRaw();
  return gameLengthMS;
}

getGameTimePassedSeconds() {
  gameLengthMS = getGameTimePassedMS();
  gameLengthSeconds = int(gameLengthMS / 1000);
  return gameLengthSeconds;
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

getTimeDeciSeconds() {
  return convertMillisecondsToDeciSecondsAndClampToShort(getTime());
}

getTimePassedDeciSeconds() {
  return convertMillisecondsToDeciSecondsAndClampToShort(getTimePassed());
}

getTimePassedDeciSecondsIncludingRounds() {
  timePassedIncludingRoundsMs = getGameTimePassedMS();
  return convertMillisecondsToDeciSecondsAndClampToShort(timePassedIncludingRoundsMs);
}

convertMillisecondsToDeciSecondsAndClampToShort(value) {
  return clampToShort(value / 100);
}

clampToShort(value) {
  value = int(value);
  if(value > 32767) {
    value = 32767;
  }
  if(value < -32768) {
    value = -32768;
  }
  return value;
}

clampToByte(value) {
  value = int(value);
  if(value > 255) {
    value = 255;
  }
  if(value < 0) {
    value = 0;
  }
  return value;
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
  if(value > maxValue) {
    return maxValue;
  } else if(value < minValue) {
    return minValue;
  } else {
    return value;
  }
}

logXPGains() {
  if(!isDefined(self.pers["summary"])) {
    return;
  }

  if(IsAI(self)) {
    return;
  }

  timePlayed = 0;

  if(isDefined(self.timePlayed["total"])) {
    timePlayed = self.timePlayed["total"];
  }

  ReconEvent("script_EarnedXP: totalXP %d, timeplayed %d, score %d, challenge %d, match %d, misc %d, gamemode %s", self.pers["summary"]["xp"], timePlayed, self.pers["summary"]["score"], self.pers["summary"]["challenge"], self.pers["summary"]["match"], self.pers["summary"]["misc"], level.gametype);
}

registerRoundSwitchDvar(dvarString, defaultValue, minValue, maxValue) {
  registerWatchDvarInt("roundswitch", defaultValue);

  dvarString = ("scr_" + dvarString + "_roundswitch");

  level.roundswitchDvar = dvarString;
  level.roundswitchMin = minValue;
  level.roundswitchMax = maxValue;
  level.roundswitch = getDvarInt(dvarString, defaultValue);

  if(level.roundswitch < minValue) {
    level.roundswitch = minValue;
  } else if(level.roundswitch > maxValue) {
    level.roundswitch = maxValue;
  }
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
  if(self GetStance() == "crouch") {
    center = self.origin + (0, 0, 24);
  } else if(self GetStance() == "prone") {
    center = self.origin + (0, 0, 10);
  } else {
    center = self.origin + (0, 0, 32);
  }

  return center;
}

get_damageable_grenade_pos(grenade) {
  return grenade.origin;
}

getDvarVec(dvarName) {
  dvarString = getDvar(dvarName);

  if(dvarString == "") {
    return (0, 0, 0);
  }

  dvarTokens = strTok(dvarString, " ");

  if(dvarTokens.size < 3) {
    return (0, 0, 0);
  }

  setDvar("tempR", dvarTokens[0]);
  setDvar("tempG", dvarTokens[1]);
  setDvar("tempB", dvarTokens[2]);

  return ((getDvarFloat("tempR"), getDvarFloat("tempG"), getDvarFloat("tempB")));
}

strip_suffix(lookupString, stripString) {
  if(lookupString.size <= stripString.size) {
    return lookupString;
  }

  if(getSubStr(lookupString, lookupString.size - stripString.size, lookupString.size) == stripString) {
    return getSubStr(lookupString, 0, lookupString.size - stripString.size);
  }

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

  saveData.offhandClass = self getTacticalWeapon();
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

    if(isDefined(self.throwingGrenade) && self.throwingGrenade == weapon) {
      saveWeapon.stockAmmo--;
    }

    assert(saveWeapon.stockAmmo >= 0);

    saveData.weapons[saveData.weapons.size] = saveWeapon;
  }

  self.script_saveData = saveData;
}

restoreData() {
  saveData = self.script_saveData;

  self setTacticalWeapon(saveData.offhandClass);

  foreach(weapon in saveData.weapons) {
    self _giveWeapon(weapon.name, int(tableLookup("mp/camoTable.csv", 1, self.loadoutPrimaryCamo, 0)));

    self setWeaponAmmoClip(weapon.name, weapon.clipAmmoR, "right");
    if(isSubStr(weapon.name, "akimbo")) {
      self setWeaponAmmoClip(weapon.name, weapon.clipAmmoL, "left");
    }

    self setWeaponAmmoStock(weapon.name, weapon.stockAmmo);
  }

  foreach(slotID, actionSlot in saveData.actionSlots) {
    self _setActionSlot(slotID, actionSlot.type, actionSlot.item);
  }

  if(self getCurrentWeapon() == "none") {
    weapon = saveData.currentWeapon;

    if(weapon == "none") {
      weapon = self getLastWeapon();
    }

    self setSpawnWeapon(weapon);
    self switchToWeapon(weapon);
  }
}

setExtraScore0(newValue) {
  self.extrascore0 = newValue;
  self setPersStat("extrascore0", newValue);
}

setExtraScore1(newValue) {
  self.extrascore1 = newValue;
  self setPersStat("extrascore1", newValue);
}

_setActionSlot(slotID, type, item) {
  self.saved_actionSlotData[slotID].type = type;
  self.saved_actionSlotData[slotID].item = item;

  self setActionSlot(slotID, type, item);
}

isFloat(value) {
  if(int(value) != value) {
    return true;
  }

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
      if(level.watchDvars[dvarString].type == "string") {
        dvarValue = getProperty(dvarString, level.watchDvars[dvarString].value);
      } else if(level.watchDvars[dvarString].type == "float") {
        dvarValue = getFloatProperty(dvarString, level.watchDvars[dvarString].value);
      } else {
        dvarValue = getIntProperty(dvarString, level.watchDvars[dvarString].value);
      }

      if(dvarValue != level.watchDvars[dvarString].value) {
        level.watchDvars[dvarString].value = dvarValue;
        level notify(level.watchDvars[dvarString].notifyString, dvarValue);
      }
    }

    wait(1.0);
  }
}

isRoundBased() {
  if(!level.teamBased) {
    return false;
  }

  if(getWatchedDvar("winlimit") != 1 && getWatchedDvar("roundlimit") != 1) {
    return true;
  }

  return false;
}

isFirstRound() {
  if(!level.teamBased) {
    return true;
  }

  if(getWatchedDvar("roundlimit") > 1 && game["roundsPlayed"] == 0) {
    return true;
  }

  if(getWatchedDvar("winlimit") > 1 && game["roundsWon"]["allies"] == 0 && game["roundsWon"]["axis"] == 0) {
    return true;
  }

  return false;
}

isLastRound() {
  if(!level.teamBased) {
    return true;
  }

  if(getWatchedDvar("roundlimit") > 1 && game["roundsPlayed"] >= (getWatchedDvar("roundlimit") - 1)) {
    return true;
  }

  if(getWatchedDvar("winlimit") > 1 && game["roundsWon"]["allies"] >= getWatchedDvar("winlimit") - 1 && game["roundsWon"]["axis"] >= getWatchedDvar("winlimit") - 1) {
    return true;
  }

  return false;
}

wasOnlyRound() {
  if(!level.teamBased) {
    return true;
  }

  if(isDefined(level.onlyRoundOverride)) {
    return false;
  }

  if(getWatchedDvar("winlimit") == 1 && hitWinLimit()) {
    return true;
  }

  if(getWatchedDvar("roundlimit") == 1) {
    return true;
  }

  return false;
}

wasLastRound() {
  if(level.forcedEnd) {
    return true;
  }

  if(!level.teamBased) {
    return true;
  }

  if(hitRoundLimit() || hitWinLimit()) {
    return true;
  }

  return false;
}

hitRoundLimit() {
  if(getWatchedDvar("roundlimit") <= 0) {
    return false;
  }

  return (game["roundsPlayed"] >= getWatchedDvar("roundlimit"));
}

hitScoreLimit() {
  if(isObjectiveBased()) {
    return false;
  }

  if(getWatchedDvar("scorelimit") <= 0) {
    return false;
  }

  if(level.teamBased) {
    if(game["teamScores"]["allies"] >= getWatchedDvar("scorelimit") || game["teamScores"]["axis"] >= getWatchedDvar("scorelimit")) {
      return true;
    }
  } else {
    for(i = 0; i < level.players.size; i++) {
      player = level.players[i];
      if(isDefined(player.score) && player.score >= getWatchedDvar("scorelimit")) {
        return true;
      }
    }
  }
  return false;
}

hitWinLimit() {
  if(getWatchedDvar("winlimit") <= 0) {
    return false;
  }

  if(!level.teamBased) {
    return true;
  }

  if(getRoundsWon("allies") >= getWatchedDvar("winlimit") || getRoundsWon("axis") >= getWatchedDvar("winlimit")) {
    return true;
  }

  return false;
}

getScoreLimit() {
  if(isRoundBased()) {
    if(getWatchedDvar("roundlimit")) {
      return (getWatchedDvar("roundlimit"));
    } else {
      return (getWatchedDvar("winlimit"));
    }
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
  if(inOvertime()) {
    timeLimit = float(getDvar("overtimeTimeLimit"));

    if(!isDefined(timeLimit)) {
      timeLimit = 1;
    }

    return timeLimit;
  }

  return getWatchedDvar("timelimit");
}

getHalfTime() {
  if(inOvertime()) {
    return false;
  }

  return getWatchedDvar("halftime");
}

inOvertime() {
  return isDefined(game["status"]) && isOvertimeText(game["status"]);
}

isOvertimeText(text) {
  return (text == "overtime") || (text == "overtime_halftime");
}

gameHasStarted() {
  if(isDefined(level.gameHasStarted)) {
    return level.gameHasStarted;
  }

  if(level.teamBased) {
    return (level.hasSpawned["axis"] && level.hasSpawned["allies"]);
  }

  return (level.maxPlayerCount > 1);
}

getAverageOrigin(ent_array) {
  avg_origin = (0, 0, 0);

  if(!ent_array.size) {
    return undefined;
  }

  foreach(ent in ent_array) {
    avg_origin += ent.origin;
  }

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
      if(team == player.pers["team"]) {
        player_array[player_array.size] = player;
      }
    } else {
      player_array[player_array.size] = player;
    }
  }

  return player_array;
}

setUsingRemote(remoteName) {
  if(isDefined(self.carryIcon)) {
    self.carryIcon.alpha = 0;
  }

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
    self freezeControls(true);
    return;
  }

  self freezeControls(frozen);
  self.controlsFrozen = frozen;
}

freezeControlsWrapperWithDelay(frozen, delay_time) {
  wait(delay_time);

  if(isDefined(self)) {
    self freezeControlsWrapper(frozen);
  }
}

clearUsingRemote() {
  if(isDefined(self.carryIcon)) {
    self.carryIcon.alpha = 1;
  }

  self.usingRemote = undefined;
  self _enableOffhandWeapons();

  curWeapon = self getCurrentWeapon();

  if(curWeapon == "none" || isKillstreakWeapon(curWeapon)) {
    self switchToWeapon(self Getlastweapon());
  }

  self freezeControlsWrapper(false);

  self playerRemoteKillstreakShowHud();

  self notify("stopped_using_remote");
}

playerRemoteKillstreakHideHud() {
  self SetClientOmnvar("ui_killstreak_remote", true);
}

playerRemoteKillstreakShowHud() {
  self SetClientOmnvar("ui_killstreak_remote", false);
}

get_water_weapon() {
  if(isDefined(self.underwaterMotionType)) {
    if(self.underwaterMotionType == "shallow" && isDefined(level.shallow_water_weapon)) {
      return level.shallow_water_weapon;
    }
    if(self.underwaterMotionType == "deep" && isDefined(level.deep_water_weapon)) {
      return level.deep_water_weapon;
    }
    if(self.underwaterMotionType != "none" && isDefined(level.shallow_water_weapon)) {
      return level.shallow_water_weapon;
    }
  }
  return "none";
}

isUsingRemote() {
  return (isDefined(self.usingRemote));
}

isInRemoteTransition() {
  return (isDefined(self.remoteRideTransition));
}

isRocketCorpse() {
  return (isDefined(self.isRocketCorpse) && self.isRocketCorpse);
}

queueCreate(queueName) {
  if(!isDefined(level.queues)) {
    level.queues = [];
  }

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

    if(!isDefined(first)) {
      first = element;
    } else {
      newQueue[newQueue.size] = element;
    }
  }

  level.queues[queueName] = newQueue;

  return first;
}

_giveWeapon(weapon, variant, dualWieldOverRide) {
  if(!isDefined(variant)) {
    variant = -1;
  }

  inHybridSight = false;
  if(isDefined(self.pers["toggleScopeStates"]) && isDefined(self.pers["toggleScopeStates"][weapon])) {
    inHybridSight = self.pers["toggleScopeStates"][weapon];
  }

  if(isSubstr(weapon, "_akimbo") || isDefined(dualWieldOverRide) && dualWieldOverRide == true) {
    if(IsAgent(self)) {
      self giveWeapon(weapon, variant, true, -1, false);
    } else {
      self giveWeapon(weapon, variant, true, -1, false, self, inHybridSight);
    }
  } else {
    if(isAgent(self)) {
      self giveWeapon(weapon, variant, false, -1, false);
    } else {
      self giveWeapon(weapon, variant, false, -1, false, self, inHybridSight);
    }
  }

}

_hasPerk(perkName) {
  if(isDefined(self.perks) && isDefined(self.perks[perkName])) {
    return true;
  }

  return false;
}

givePerk(perkName, useSlot, setSlot) {
  AssertEx(isDefined(perkName), "givePerk perkName not defined and should be");
  AssertEx(isDefined(useSlot), "givePerk useSlot not defined and should be");
  AssertEx(!IsSubStr(perkName, "specialty_null"), "givePerk perkName shouldn't be specialty_null, use _clearPerks()s");

  if(IsSubStr(perkName, "_mp")) {
    self _giveWeapon(perkName, 0);
    self giveStartAmmo(perkName);

    self _setPerk(perkName, useSlot);
    return;
  }

  if(IsSubStr(perkName, "specialty_weapon_")) {
    self _setPerk(perkName, useSlot);
    return;
  }

  self _setPerk(perkName, useSlot, setSlot);
}

_setPerk(perkName, useSlot, setSlot) {
  AssertEx(isDefined(perkName), "_setPerk perkName not defined and should be");
  AssertEx(isDefined(useSlot), "_setPerk useSlot not defined and should be");

  self.perks[perkName] = true;
  self.perksPerkName[perkName] = perkName;
  self.perksUseSlot[perkName] = useSlot;

  if(isDefined(level.perkSetFuncs[perkName])) {
    self thread[[level.perkSetFuncs[perkName]]]();
  }

  shortPerkName = maps\mp\_utility::strip_suffix(perkName, "_lefthand");

  if(isDefined(setSlot)) {
    self setPerk(perkName, !isDefined(level.scriptPerks[shortPerkName]), useSlot, setSlot);
  } else {
    self setPerk(perkName, !isDefined(level.scriptPerks[shortPerkName]), useSlot);
  }
}

_unsetPerk(perkName) {
  self.perks[perkName] = undefined;
  self.perksPerkName[perkName] = undefined;
  self.perksUseSlot[perkName] = undefined;
  self.perksPerkPower[perkName] = undefined;

  if(isDefined(level.perkUnsetFuncs[perkName])) {
    self thread[[level.perkUnsetFuncs[perkName]]]();
  }

  shortPerkName = maps\mp\_utility::strip_suffix(perkName, "_lefthand");

  self unsetPerk(perkName, !isDefined(level.scriptPerks[shortPerkName]));
}

_clearPerks() {
  foreach(perkName, perkValue in self.perks) {
    if(isDefined(level.perkUnsetFuncs[perkName])) {
      self[[level.perkUnsetFuncs[perkName]]]();
    }
  }

  self.perks = [];
  self.perksPerkName = [];
  self.perksUseSlot = [];
  self.perksPerkPower = [];
  self clearPerks();
}

canGiveAbility(abilityName) {
  AssertEx(isDefined(abilityName), "canGiveAbility abilityName not defined and should be");
  AssertEx(!IsSubStr(abilityName, "specialty_null"), "canGiveAbility abilityName shouldn't be specialty_null, use _clearAbilities()");

  return self _canGiveAbility(abilityName);
}

_canGiveAbility(abilityName) {
  AssertEx(isDefined(abilityName), "_canGiveAbility abilityName not defined and should be");

  if(!isDefined(level.abilityCanSetFuncs) || !isDefined(level.abilityCanSetFuncs[abilityName])) {
    return true;
  }

  return self[[level.abilityCanSetFuncs[abilityName]]]();
}

giveAbility(abilityName, useSlot) {
  AssertEx(isDefined(abilityName), "giveAbility abilityName not defined and should be");
  AssertEx(isDefined(useSlot), "giveAbility useSlot not defined and should be");
  AssertEx(!IsSubStr(abilityName, "specialty_null"), "giveAbility abilityName shouldn't be specialty_null, use _clearAbilities()");

  self _setAbility(abilityName, useSlot);
}

_setAbility(abilityName, useSlot) {
  AssertEx(isDefined(abilityName), "_setAbility abilityName not defined and should be");
  AssertEx(isDefined(useSlot), "_setAbility useSlot not defined and should be");

  self.abilities[abilityName] = true;

  if(isPlayer(self)) {
    if(isDefined(level.abilitySetFuncs[abilityName])) {
      self thread[[level.abilitySetFuncs[abilityName]]]();
    }
  }

  self SetPerk(abilityName, !isDefined(level.scriptAbilities[abilityName]), useSlot);
}

_unsetAbility(abilityName) {
  self.abilities[abilityName] = undefined;

  if(isPlayer(self)) {
    if(isDefined(level.abilityUnsetFuncs[abilityName])) {
      self thread[[level.abilityUnsetFuncs[abilityName]]]();
    }
  }

  self UnSetPerk(abilityName, !isDefined(level.scriptAbilities[abilityName]));
}

_clearAbilities() {
  if(isPlayer(self)) {
    if(isDefined(level.abilityUnsetFuncs[self.pers["ability"]])) {
      self[[level.abilityUnsetFuncs[self.pers["ability"]]]]();
    }
  }

  self.abilities = [];
  self clearPerks();
}

_hasAbility(abilityName, isPassiveAbility) {
  if(!isDefined(isPassiveAbility)) {
    isPassiveAbility = false;
  }

  if(isPassiveAbility) {
    if(isDefined(self.abilities[abilityName]) && self.abilities[abilityName]) {
      return true;
    }
  } else {
    if(isDefined(self.pers["ability"]) && self.pers["ability"] == abilityName && isDefined(self.pers["abilityOn"]) && self.pers["abilityOn"]) {
      return true;
    }
  }

  return false;
}

quickSort(array, compare_func) {
  return quickSortMid(array, 0, array.size - 1, compare_func);
}

quickSortMid(array, start, end, compare_func) {
  i = start;
  k = end;

  if(!isDefined(compare_func)) {
    compare_func = ::quickSort_compare;
  }

  if(end - start >= 1) {
    pivot = array[start];

    while(k > i) {
      while([[compare_func]](array[i], pivot) && i <= end && k > i) {
        i++;
      }
      while(![[compare_func]](array[k], pivot) && k >= start && k >= i) {
        k--;
      }
      if(k > i) {
        array = swap(array, i, k);
      }
    }
    array = swap(array, start, k);
    array = quickSortMid(array, start, k - 1, compare_func);
    array = quickSortMid(array, k + 1, end, compare_func);
  } else {
    return array;
  }

  return array;
}

quicksort_compare(left, right) {
  return left <= right;
}

swap(array, index1, index2) {
  temp = array[index1];
  array[index1] = array[index2];
  array[index2] = temp;
  return array;
}

_suicide() {
  if(self isUsingRemote() && !isDefined(self.fauxDead)) {
    self thread maps\mp\gametypes\_damage::PlayerKilled_internal(self, self, self, 10000, "MOD_SUICIDE", "frag_grenade_mp", (0, 0, 0), "none", 0, 1116, true);
  } else if(!self isUsingRemote() && !isDefined(self.fauxDead)) {
    self suicide();
  }
}

isReallyAlive(player) {
  if(isAlive(player) && !isDefined(player.fauxDead)) {
    return true;
  }

  return false;
}

waittill_any_timeout_pause_on_death_and_prematch(timeOut, string1, string2, string3, string4, string5) {
  ent = spawnStruct();

  if(isDefined(string1)) {
    self thread waittill_string_no_endon_death(string1, ent);
  }

  if(isDefined(string2)) {
    self thread waittill_string_no_endon_death(string2, ent);
  }

  if(isDefined(string3)) {
    self thread waittill_string_no_endon_death(string3, ent);
  }

  if(isDefined(string4)) {
    self thread waittill_string_no_endon_death(string4, ent);
  }

  if(isDefined(string5)) {
    self thread waittill_string_no_endon_death(string5, ent);
  }

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
    if(GetDvarInt("ui_inprematch")) {
      level waittill("prematch_over");
    }

    wait(inc);
    delay -= inc;
  }
  self notify("returned", "timeout");
}

playDeathSound() {
  if(isDefined(level.customPlayDeathSound)) {
    self thread[[level.customPlayDeathSound]]();
    return;
  }

  rand = RandomIntRange(1, 8);

  if(self maps\mp\killstreaks\_juggernaut::get_is_in_mech()) {
    return;
  }

  if(self.team == "axis") {
    if(self HasFemaleCustomizationModel()) {
      self playSound("generic_death_enemy_fm_" + rand);
    } else {
      self playSound("generic_death_enemy_" + rand);
    }
  } else {
    if(self HasFemaleCustomizationModel()) {
      self playSound("generic_death_friendly_fm_" + rand);
    } else {
      self playSound("generic_death_friendly_" + rand);
    }
  }
}

rankingEnabled() {
  if(!isPlayer(self)) {
    return false;
  }

  return (level.rankedMatch && !self.usingOnlineDataOffline);
}

privateMatch() {
  return (!level.onlineGame || getDvarInt("xblive_privatematch"));
}

matchMakingGame() {
  return (level.onlineGame && !getDvarInt("xblive_privatematch"));
}

practiceRoundGame() {
  return (level.practiceRound);
}

setAltSceneObj(object, tagName, fov, forceLink) {}

endSceneOnDeath(object) {
  self endon("altscene");

  object waittill("death");
  self notify("end_altScene");
}

getMapName() {
  return getDvar("mapname");
}

getGametypeNumLives() {
  return getWatchedDvar("numlives");
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
  return true;
}

isJuggernaut() {
  if((isDefined(self.isJuggernaut) && self.isJuggernaut == true)) {
    return true;
  }

  if((isDefined(self.isJuggernautDef) && self.isJuggernautDef == true)) {
    return true;
  }

  if((isDefined(self.isJuggernautGL) && self.isJuggernautGL == true)) {
    return true;
  }

  if((isDefined(self.isJuggernautRecon) && self.isJuggernautRecon == true)) {
    return true;
  }

  if((isDefined(self.isJuggernautManiac) && self.isJuggernautManiac == true)) {
    return true;
  }

  return false;
}

isKillstreakWeapon(weapon) {
  if(!isDefined(weapon)) {
    AssertMsg("isKillstreakWeapon called without a weapon name passed in");
    return false;
  }

  if(weapon == "none") {
    return false;
  }

  if(isDestructibleWeapon(weapon)) {
    return false;
  }

  if(isBombSiteWeapon(weapon)) {
    return false;
  }

  if(isSubStr(weapon, "killstreak")) {
    return true;
  }

  if(weapon == "airdrop_sentry_marker_mp") {
    return true;
  }

  tokens = getWeaponNameTokens(weapon);
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

  if(maps\mp\killstreaks\_airdrop::isAirdropMarker(weapon)) {
    return true;
  }

  if(isDefined(level.killstreakWieldWeapons[weapon])) {
    return true;
  }

  weaponInvType = WeaponInventoryType(weapon);
  if(isDefined(weaponInvType) && weaponInvType == "exclusive") {
    return true;
  }

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

isAugmentedGameMode() {
  return GetDvarInt("scr_game_high_jump", 0);
}

isGrapplingHookGameMode() {
  return GetDvarInt("scr_game_grappling_hook", 0);
}

isDivisionMode() {
  return GetDvarInt("scr_game_division", 0);
}

isBombSiteWeapon(weapon) {
  if(!isDefined(weapon)) {
    AssertMsg("isBombSiteWeapon called without a weapon name passed in");
    return false;
  }

  switch (weapon) {
    case "search_dstry_bomb_mp":
    case "search_dstry_bomb_defuse_mp":
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

  if(weapon == "turret_minigun_mp") {
    return true;
  }

  if(isSubStr(weapon, "_bipod_")) {
    return true;
  }

  return false;
}

isLootWeapon(weaponName) {
  if(IsSubStr(weaponName, "loot")) {
    return true;
  }

  if(IsSubStr(weaponName, "atlas")) {
    return true;
  }

  if(IsSubStr(weaponName, "gold")) {
    return true;
  }

  if(IsSubStr(weaponName, "blops2")) {
    return true;
  }

  if(IsSubStr(weaponName, "ghosts")) {
    return true;
  }

  return false;
}

getWeaponNameTokens(weaponName) {
  return strTok(weaponName, "_");
}

getWeaponClass(weapon) {
  baseName = getBaseWeaponName(weapon);

  weaponClass = tablelookup("mp/statstable.csv", 4, baseName, 2);

  if(weaponClass == "") {
    weaponName = maps\mp\_utility::strip_suffix(weapon, "_lefthand");
    weaponName = maps\mp\_utility::strip_suffix(weaponName, "_mp");
    weaponClass = tablelookup("mp/statstable.csv", 4, weaponName, 2);
  }

  if(isEnvironmentWeapon(weapon)) {
    weaponClass = "weapon_mg";
  } else if(isKillstreakWeapon(weapon)) {
    weaponClass = "killstreak";
  } else if(weapon == "none") {
    weaponClass = "other";
  } else if(weaponClass == "") {
    weaponClass = "other";
  }

  assertEx(weaponClass != "", "ERROR: invalid weapon class for weapon " + weapon);

  return weaponClass;
}

getWeaponAttachmentArrayFromStats(weaponName) {
  weaponName = getBaseWeaponName(weaponName);

  if(!isDefined(level.weaponAttachments[weaponName])) {
    attachments = [];
    for(i = 0; i <= 29; i++) {
      attachment = TableLookup("mp/statsTable.csv", 4, weaponName, 11 + i);
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

  return TableLookup("mp/statsTable.csv", 4, weaponName, 11 + index);
}

getBaseWeaponName(weaponName) {
  tokens = getWeaponNameTokens(weaponName);

  retval = "";

  if(tokens[0] == "iw5" || tokens[0] == "iw6" || tokens[0] == "s1") {
    retval = tokens[0] + "_" + tokens[1];
  } else if(tokens[0] == "alt") {
    retval = tokens[1] + "_" + tokens[2];
  } else if((tokens.size > 1) && ((tokens[1] == "grenade") || (tokens[1] == "marker"))) {
    retval = tokens[0] + "_" + tokens[1];
  } else {
    retval = tokens[0];
  }

  return retval;
}

fixAkimboString(weaponName, append) {
  if(!isDefined(append)) {
    append = true;
  }

  startIndex = 0;
  for(i = 0; i < weaponName.size; i++) {
    if(weaponName[i] == "a" && weaponName[i + 1] == "k" && weaponName[i + 2] == "i" && weaponName[i + 3] == "m" && weaponName[i + 4] == "b" && weaponName[i + 5] == "o") {
      startIndex = i;
      break;
    }
  }

  weaponName = GetSubStr(weaponName, 0, startIndex) + GetSubStr(weaponName, startIndex + 6, weaponName.size);

  if(append) {
    weaponName += "_akimbo";
  }

  return weaponName;
}

playSoundinSpace(alias, origin) {
  playSoundAtPos(origin, alias);
}

limitDecimalPlaces(value, places) {
  modifier = 1;
  for(i = 0; i < places; i++) {
    modifier *= 10;
  }

  newvalue = value * modifier;
  newvalue = Int(newvalue);
  newvalue = newvalue / modifier;

  return newvalue;
}

roundDecimalPlaces(value, places, style) {
  if(!isDefined(style)) {
    style = "nearest";
  }

  modifier = 1;
  for(i = 0; i < places; i++) {
    modifier *= 10;
  }

  newValue = value * modifier;

  if(style == "up") {
    roundedValue = ceil(newValue);
  } else if(style == "down") {
    roundedValue = floor(newValue);
  } else {
    roundedValue = newvalue + 0.5;
  }

  newvalue = Int(roundedValue);
  newvalue = newvalue / modifier;

  return newvalue;
}

playerForClientId(clientId) {
  foreach(player in level.players) {
    if(player.clientId == clientId) {
      return player;
    }
  }

  return undefined;
}

stringToFloat(stringVal) {
  floatElements = strtok(stringVal, ".");

  floatVal = int(floatElements[0]);
  if(isDefined(floatElements[1])) {
    modifier = 1;
    for(i = 0; i < floatElements[1].size; i++) {
      modifier *= 0.1;
    }

    floatVal += int(floatElements[1]) * modifier;
  }

  return floatVal;
}

setSelfUsable(caller) {
  self makeUsable();

  foreach(player in level.players) {
    if(player != caller) {
      self disablePlayerUse(player);
    } else {
      self enablePlayerUse(player);
    }
  }
}

setSelfUnusuable() {
  self makeUnusable();

  foreach(player in level.players) {
    self disablePlayerUse(player);
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
      if(player.team == team) {
        self enablePlayerUse(player);
      } else {
        self disablePlayerUse(player);
      }
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
        if(player.team != team) {
          self enablePlayerUse(player);
        } else {
          self disablePlayerUse(player);
        }
      }
    } else {
      foreach(player in level.players) {
        if(player != owner) {
          self enablePlayerUse(player);
        } else {
          self disablePlayerUse(player);
        }
      }
    }

    level waittill("joined_team");
  }
}

getNextLifeId() {
  lifeId = getMatchData("lifeCount");
  if(lifeId < level.MaxLives) {
    setMatchData("lifeCount", lifeId + 1);
    return (lifeId);
  } else {
    return (level.MaxLives - 1);
  }
}

initGameFlags() {
  if(!isDefined(game["flags"])) {
    game["flags"] = [];
  }
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
  while(!gameFlag(flagName)) {
    level waittill(flagName);
  }
}

isBulletDamage(meansofdeath) {
  bulletDamage = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";
  if(isSubstr(bulletDamage, meansofdeath)) {
    return true;
  }
  return false;
}

isFMJDamage(sWeapon, sMeansOfDeath, attacker) {
  return isDefined(attacker) && isPlayer(attacker) && attacker _hasPerk("specialty_bulletpenetration") && isDefined(sMeansOfDeath) && isBulletDamage(sMeansOfDeath);
}

initLevelFlags() {
  if(!isDefined(level.levelFlags)) {
    level.levelFlags = [];
  }
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
  while(!levelFlag(flagName)) {
    level waittill(flagName);
  }
}

levelFlagWaitOpen(flagName) {
  assertEx(isDefined(level.levelFlags[flagName]), "levelFlag " + flagName + " referenced without being initialized; use levelFlagInit( <flagName>, <isEnabled> )");
  while(levelFlag(flagName)) {
    level waittill(flagName);
  }
}

inVirtualLobby() {
  if(!isDefined(level.virtualLobbyActive) || (level.virtualLobbyActive == 0)) {
    return false;
  }
  return true;
}

initGlobals() {
  if(!isDefined(level.global_tables)) {
    level.global_tables["killstreakTable"] = spawnStruct();
    level.global_tables["killstreakTable"].path = "mp/killstreakTable.csv";
    level.global_tables["killstreakTable"].index_col = 0;
    level.global_tables["killstreakTable"].ref_col = 1;
    level.global_tables["killstreakTable"].name_col = 2;
    level.global_tables["killstreakTable"].desc_col = 3;
    level.global_tables["killstreakTable"].adrenaline_col = 4;
    level.global_tables["killstreakTable"].earned_hint_col = 5;
    level.global_tables["killstreakTable"].sound_col = 6;
    level.global_tables["killstreakTable"].earned_dialog_col = 7;
    level.global_tables["killstreakTable"].allies_dialog_col = 8;
    level.global_tables["killstreakTable"].opfor_dialog_col = 9;
    level.global_tables["killstreakTable"].enemy_use_dialog_col = 10;
    level.global_tables["killstreakTable"].weapon_col = 11;
    level.global_tables["killstreakTable"].score_col = 12;
    level.global_tables["killstreakTable"].icon_col = 13;
    level.global_tables["killstreakTable"].overhead_icon_col = 14;
    level.global_tables["killstreakTable"].overhead_icon_col_plus1 = 15;
    level.global_tables["killstreakTable"].overhead_icon_col_plus2 = 16;
    level.global_tables["killstreakTable"].overhead_icon_col_plus3 = 17;
    level.global_tables["killstreakTable"].dpad_icon_col = 18;
    level.global_tables["killstreakTable"].unearned_icon_col = 19;
  }
}

isKillStreakDenied() {
  if(inVirtualLobby()) {
    return false;
  }
  return (self isEMPed() || self isAirDenied());
}

isEMPed() {
  if(self.team == "spectator") {
    return false;
  }

  if(inVirtualLobby()) {
    return false;
  }

  if(level.teamBased) {
    return (level.teamEMPed[self.team] || (isDefined(self.empGrenaded) && self.empGrenaded));
  } else {
    return ((isDefined(level.empPlayer) && level.empPlayer != self) || (isDefined(self.empGrenaded) && self.empGrenaded));
  }
}

isEMPedByKillstreak() {
  if(self.team == "spectator") {
    return false;
  }

  if(inVirtualLobby()) {
    return false;
  }

  if(level.teamBased) {
    return (level.teamEMPed[self.team]);
  } else {
    return ((isDefined(level.empPlayer) && level.empPlayer != self));
  }
}

isAirDenied() {
  return false;
}

isNuked() {
  if(self.team == "spectator") {
    return false;
  }

  return (isDefined(self.nuked));
}

getPlayerForGuid(guid) {
  foreach(player in level.players) {
    if(player.guid == guid) {
      return player;
    }
  }

  return undefined;
}

teamPlayerCardSplash(splash, owner, team, optionalNumber) {
  if(level.hardCoreMode) {
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
    case "weapon_lmg":
    case "weapon_shotgun":
    case "weapon_heavy":
    case "weapon_special":
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
    case "weapon_sec_special":
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

  if(!isDefined(interval)) {
    interval = .05;
  }

  if(!isDefined(time)) {
    time = 0;
  }

  while(1) {
    if(self.health != self.maxhealth) {
      fullHealthTime = 0;
    } else {
      fullHealthTime += interval;
    }

    wait interval;

    if(self.health == self.maxhealth && fullHealthTime >= time) {
      break;
    }
  }

  return;
}

attachmentMap_toUnique(attachmentName, weaponName) {
  nameUnique = attachmentName;
  weaponName = getBaseWeaponName(weaponName);

  if(isLootWeapon(weaponName)) {
    weaponName = maps\mp\gametypes\_class::getBaseFromLootVersion(weaponName);
  }

  AssertEx(isDefined(level.attachmentMap_baseToUnique), "attachmentMap_toUnique() called without first calling buildAttachmentMaps()");

  if(isDefined(level.attachmentMap_baseToUnique[weaponName]) && isDefined(level.attachmentMap_baseToUnique[weaponName][attachmentName])) {
    nameUnique = level.attachmentMap_baseToUnique[weaponName][attachmentName];
  } else {
    weapClass = TableLookup("mp/statstable.csv", 4, weaponName, 2);
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
  attachmentName = TableLookup(ATTACHMENT_TABLE, ATTACHMENT_COL_INDEX, index, ATTACHMENT_COL_REF_BASE);

  while(attachmentName != "") {
    if(!array_contains(attachmentList, attachmentName)) {
      attachmentList[attachmentList.size] = attachmentName;
    }

    index++;
    attachmentName = TableLookup(ATTACHMENT_TABLE, ATTACHMENT_COL_INDEX, index, ATTACHMENT_COL_REF_BASE);
  }

  return attachmentList;
}

getAttachmentListUniqeNames() {
  attachmentList = [];

  index = 0;
  attachmentName = TableLookup(ATTACHMENT_TABLE, ATTACHMENT_COL_INDEX, index, ATTACHMENT_COL_REF_UNIQUE);

  while(attachmentName != "") {
    AssertEx(!isDefined(attachmentList[attachmentName]), "Duplicate unique attachment reference name found in attachmentTable.csv");

    attachmentList[attachmentList.size] = attachmentName;

    index++;
    attachmentName = TableLookup(ATTACHMENT_TABLE, ATTACHMENT_COL_INDEX, index, ATTACHMENT_COL_REF_UNIQUE);
  }

  return attachmentList;
}

buildAttachmentMaps() {
  AssertEx(!isDefined(level.attachmentMap_uniqueToBase), "buildAttachmentMaps() called when map already existed.");

  attachmentNamesUnique = getAttachmentListUniqeNames();

  level.attachmentMap_uniqueToBase = [];

  foreach(uniqueName in attachmentNamesUnique) {
    baseName = TableLookup(ATTACHMENT_TABLE, ATTACHMENT_COL_REF_UNIQUE, uniqueName, ATTACHMENT_COL_REF_BASE);

    AssertEx(isDefined(baseName) && baseName != "", "No base attachment name found in attachmentTable.csv for: " + baseName);

    if(uniqueName == baseName) {
      continue;
    }

    level.attachmentMap_uniqueToBase[uniqueName] = baseName;
  }

  AssertEx(!isDefined(level.attachmentMap_baseToUnique), "buildAttachmentMaps() called when map already existed.");

  weaponClassesAndNames = [];
  idxRow = 1;
  classOrName = TableLookupByRow(ATTACHMAP_TABLE, idxRow, ATTACHMAP_COL_CLASS_OR_WEAP_NAME);
  while(classOrName != "") {
    weaponClassesAndNames[weaponClassesAndNames.size] = classOrName;

    idxRow++;
    classOrName = TableLookupByRow(ATTACHMAP_TABLE, idxRow, ATTACHMAP_COL_CLASS_OR_WEAP_NAME);
  }

  attachmentNameColumns = [];

  idxCol = 1;
  attachTitle = TableLookupByRow(ATTACHMAP_TABLE, ATTACHMAP_ROW_ATTACH_BASE_NAME, idxCol);
  while(attachTitle != "") {
    attachmentNameColumns[attachTitle] = idxCol;

    idxCol++;
    attachTitle = TableLookupByRow(ATTACHMAP_TABLE, ATTACHMAP_ROW_ATTACH_BASE_NAME, idxCol);
  }

  level.attachmentMap_baseToUnique = [];

  foreach(classOrName in weaponClassesAndNames) {
    foreach(attachment, column in attachmentNameColumns) {
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
    perkName = TableLookup(ATTACHMENT_TABLE, ATTACHMENT_COL_REF_UNIQUE, attachName, ATTACHMENT_COL_PERK);

    if(perkName == "") {
      continue;
    }

    level.attachmentMap_attachToPerk[attachName] = perkName;
  }
}

attachmentMap_toBase(attachmentName) {
  AssertEx(isDefined(level.attachmentMap_uniqueToBase), "validateAttachment() called without first calling buildAttachmentMaps()");

  if(isDefined(level.attachmentMap_uniqueToBase[attachmentName])) {
    attachmentName = level.attachmentMap_uniqueToBase[attachmentName];
  }

  return attachmentName;
}

_objective_delete(objID) {
  objective_delete(objID);

  if(!isDefined(level.reclaimedReservedObjectives)) {
    level.reclaimedReservedObjectives = [];
    level.reclaimedReservedObjectives[0] = objID;
  } else {
    level.reclaimedReservedObjectives[level.reclaimedReservedObjectives.size] = objID;
  }

  tempIDs = [];
  for(i = 0; i < 32; i++) {
    tempIDs[i] = false;
  }

  foreach(objectID in level.reclaimedReservedObjectives) {
    if(tempIDs[objectID] == true) {
      AssertMsg("Deleting Minimap objID (" + objectID + ") Twice");
    } else {
      tempIDs[objectID] = true;
    }
  }

}

touchingBadTrigger() {
  killTriggers = getEntArray("trigger_hurt", "classname");
  foreach(trigger in killTriggers) {
    if(self isTouching(trigger)) {
      return true;
    }
  }

  radTriggers = getEntArray("radiation", "targetname");
  foreach(trigger in radTriggers) {
    if(self isTouching(trigger)) {
      return true;
    }
  }

  if(getDvar("g_gametype") == "hp" && isDefined(level.zone) && isDefined(level.zone.trig) && self isTouching(level.zone.trig)) {
    return true;
  }

  return false;
}

setThirdPersonDOF(isEnabled) {
  if(isEnabled) {
    self setDepthOfField(0, 110, 512, 4096, 6, 1.8);
  } else {
    self setDepthOfField(0, 0, 512, 512, 4, 0);
  }
}

killTrigger(pos, radius, height) {
  trig = spawn("trigger_radius", pos, 0, radius, height);

  if(getDvar("scr_killtriggerdebug") == "1") {
    thread killTriggerDebug(pos, radius, height);
  }

  for(;;) {
    if(getDvar("scr_killtriggerradius") != "") {
      radius = int(getDvar("scr_killtriggerradius"));
    }

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

  if(targetCosine >= facingCosine) {
    return true;
  } else {
    return false;
  }
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
  if(!isDefined(scaler)) {
    scaler = 0;
  }

  if(!isDefined(self.recoilScale)) {
    self.recoilScale = scaler;
  } else {
    self.recoilScale += scaler;
  }

  if(isDefined(scaleOverride)) {
    if(isDefined(self.recoilScale) && scaleOverride < self.recoilScale) {
      scaleOverride = self.recoilScale;
    }

    scale = 100 - scaleOverride;
  } else {
    scale = 100 - self.recoilScale;
  }

  if(scale < 0) {
    scale = 0;
  }

  if(scale > 100) {
    scale = 100;
  }

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

  if(isDefined(level.killstreaksDisabled) && level.killstreaksDisabled) {
    return false;
  }

  if(!self IsOnGround() && isRideKillstreak(streakName)) {
    return false;
  }

  if(self isUsingRemote() || self isInRemoteTransition()) {
    return false;
  }

  if(isDefined(self.selectingLocation)) {
    return false;
  }

  if(shouldPreventEarlyUse(streakName) && level.killstreakRoundDelay) {
    timePassed = 0;
    if(isDefined(level.prematch_done_time)) {
      timePassed = (GetTime() - level.prematch_done_time) / 1000;
    }

    if(timePassed < level.killstreakRoundDelay) {
      timeUntilUse = int(level.killstreakRoundDelay - timePassed + 0.5);
      if(!timeUntilUse) {
        timeUntilUse = 1;
      }
      if(!(isDefined(disable_print_output) && disable_print_output)) {
        self IPrintLnBold(&"MP_UNAVAILABLE_FOR_N", timeUntilUse);
      }
      return false;
    }
  }

  if(self isEMPed()) {
    if(!(isDefined(disable_print_output) && disable_print_output)) {
      if(isDefined(level.empTimeRemaining) && level.empTimeRemaining > 0) {
        self IPrintLnBold(&"MP_UNAVAILABLE_FOR_N_WHEN_EMP", level.empTimeRemaining);
      } else if(isDefined(self.empEndTime) && Int((self.empEndTime - GetTime()) / 1000) > 0) {
        self IPrintLnBold(&"MP_UNAVAILABLE_FOR_N", Int((self.empEndTime - GetTime()) / 1000));
      }
    }
    return false;
  }

  if(self IsUsingTurret() && (isRideKillstreak(streakName) || isCarryKillstreak(streakName))) {
    if(!(isDefined(disable_print_output) && disable_print_output)) {
      self IPrintLnBold(&"MP_UNAVAILABLE_USING_TURRET");
    }
    return false;
  }

  if(isDefined(self.lastStand) && !self _hasPerk("specialty_finalstand")) {
    if(!(isDefined(disable_print_output) && disable_print_output)) {
      self IPrintLnBold(&"MP_UNAVILABLE_IN_LASTSTAND");
    }
    return false;
  }

  if(!self isWeaponEnabled()) {
    return false;
  }

  return true;
}

isRideKillstreak(streakName) {
  switch (streakName) {
    case "missile_strike":
    case "orbital_strike":
    case "orbital_strike_laser":
    case "orbital_strike_chem":
    case "orbital_strike_laser_chem":
    case "orbital_strike_cluster":
    case "orbital_strike_drone":
    case "mp_solar":
    case "mp_dam":
    case "mp_levity":
    case "mp_terrace":
    case "mp_detroit":
    case "orbitalsupport":
    case "mp_recreation":
    case "recon_ugv":
    case "warbird":
    case "assault_ugv":
      return true;

    default:
      return false;
  }
}

isCarryKillstreak(streakName) {
  switch (streakName) {
    case "sentry":
    case "deployable_ammo":
    case "deployable_grenades":
    case "deployable_exp_ammo":
    case "remote_mg_sentry_turret":
      return true;

    default:
      return false;
  }
}

shouldPreventEarlyUse(streakName) {
  switch (streakName) {
    case "warbird":
    case "missile_strike":
    case "orbitalsupport":
    case "strafing_run_airstrike":
    case "orbital_strike_laser":
      return true;
  }

  return false;
}

isKillstreakAffectedByEMP(streakName) {
  switch (streakName) {
    case "deployable_ammo":
    case "deployable_grenades":
    case "deployable_juicebox":
    case "placeable_barrier":
    case "agent":
    case "recon_agent":
    case "high_value_target":
    case "eyes_on":
    case "speed_boost":
    case "refill_grenades":
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
    case "airdrop_sentry_minigun":
    case "airdrop_assault":
    case "airdrop_support":
    case "orbitalsupport":
    case "orbital_carepackag":
    case "missile_strike":
    case "orbital_strike":
    case "orbital_strike_laser":
    case "orbital_strike_chem":
    case "orbital_strike_laser_chem":
    case "orbital_strike_cluster":
    case "orbital_strike_drone":
      return false;

    default:
      return true;
  }
}

isAllTeamStreak(streakName) {
  isTeamStreak = getKillstreakAllTeamStreak(streakName);

  if(!isDefined(isTeamStreak)) {
    return false;
  }

  if(Int(isTeamStreak) == 1) {
    return true;
  }

  return false;
}

getKillstreakRowNum(streakName) {
  return TableLookupRowNum(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName);
}

getKillstreakIndex(streakName) {
  indexString = TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].index_col);
  if(indexString == "") {
    index = -1;
  } else {
    index = int(indexString);
  }
  return index;
}

getKillstreakReference(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].ref_col);
}

getKillstreakName(streakName) {
  return TableLookupIString(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].name_col);
}

getKillstreakDescription(streakName) {
  return TableLookupIString(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].desc_col);
}

getKillstreakKills(streakName) {
  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].adrenaline_col);
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

getKillstreakWeapon(streakName, modules) {
  if(isDefined(modules) && modules.size > 0) {
    moduleWeapon = _getModuleKillstreakWeapon(streakName, modules);
    if(isDefined(moduleWeapon)) {
      return moduleWeapon;
    }
  }

  return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, streakName, level.global_tables["killstreakTable"].weapon_col);
}

_getModuleKillstreakWeapon(streakName, modules) {
  foreach(module in modules) {
    switch (module) {
      case "warbird_ai_attack":
      case "warbird_ai_follow":
        if(issubstr(streakName, "warbird")) {
          return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, "uav", level.global_tables["killstreakTable"].weapon_col);
        }
        break;
      case "assault_ugv_ai":
        if(issubstr(streakName, "ugv")) {
          return TableLookup(level.global_tables["killstreakTable"].path, level.global_tables["killstreakTable"].ref_col, "uav", level.global_tables["killstreakTable"].weapon_col);
        }
        break;
      case "turretheadenergy_mp":
      case "turretheadrocket_mp":
      case "turretheadmg_mp":
        if(issubstr(streakName, "ripped_turret")) {
          return module;
        }
        break;
      default:
        break;
    }
  }
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
  if(!isDefined(extra)) {
    extra = 0;
  }

  count = extra;
  if(isDefined(level.helis)) {
    count += level.helis.size;
  }
  if(isDefined(level.littleBirds)) {
    count += level.littleBirds.size;
  }
  if(isDefined(level.ugvs)) {
    count += level.ugvs.size;
  }

  if(isDefined(level.isHorde) && level.isHorde) {
    if(isDefined(level.flying_attack_drones)) {
      count += level.flying_attack_drones.size;
    }
    if(isDefined(level.trackingDrones)) {
      count += level.trackingDrones.size;
    }
  }

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
  if(level.fauxVehicleCount < 0) {
    level.fauxVehicleCount = 0;
  }
}

lightWeightScalar(power) {
  return LIGHTWEIGHT_SCALAR;
}

allowTeamChoice() {
  if(GetDvarInt("scr_skipclasschoice", 0) > 0) {
    return 0;
  }

  allowed = int(tableLookup("mp/gametypesTable.csv", 0, level.gameType, 4));
  assert(isDefined(allowed));

  return allowed;
}

allowClassChoice() {
  if(GetDvarInt("scr_skipclasschoice", 0) > 0) {
    return 0;
  }

  allowed = int(tableLookup("mp/gametypesTable.csv", 0, level.gameType, 5));
  assert(isDefined(allowed));

  return allowed;
}

showGenericMenuOnMatchStart() {
  if(allowTeamChoice() || allowClassChoice()) {
    return 0;
  }

  needGenericMenu = int(tableLookup("mp/gametypesTable.csv", 0, level.gameType, 7));
  assert(isDefined(needGenericMenu));

  return needGenericMenu;
}

isBuffEquippedOnWeapon(buffRef, weaponRef) {
  return false;
}

setCommonRulesFromMatchRulesData(skipFriendlyFire) {
  timeLimit = GetMatchRulesData("commonOption", "timeLimit");
  SetDynamicDvar("scr_" + level.gameType + "_timeLimit", timeLimit);
  registerTimeLimitDvar(level.gameType, timeLimit);

  scoreLimit = GetMatchRulesData("commonOption", "scoreLimit");
  SetDynamicDvar("scr_" + level.gameType + "_scoreLimit", scoreLimit);
  registerScoreLimitDvar(level.gameType, scoreLimit);

  SetDynamicDvar("scr_game_matchstarttime", GetMatchRulesData("commonOption", "preMatchTimer"));
  SetDynamicDvar("scr_game_roundstarttime", GetMatchRulesData("commonOption", "preRoundTimer"));
  SetDynamicDvar("scr_game_suicidespawndelay", GetMatchRulesData("commonOption", "suicidePenalty"));
  SetDynamicDvar("scr_team_teamkillspawndelay", GetMatchRulesData("commonOption", "teamKillPenalty"));
  SetDynamicDvar("scr_team_teamkillkicklimit", GetMatchRulesData("commonOption", "teamKillKickLimit"));

  numLives = GetMatchRulesData("commonOption", "numLives");
  SetDynamicDvar("scr_" + level.gameType + "_numLives", numLives);
  registerNumLivesDvar(level.gameType, numLives);

  SetDynamicDvar("scr_player_maxhealth", GetMatchRulesData("commonOption", "maxHealth"));
  SetDynamicDvar("scr_player_healthregentime", GetMatchRulesData("commonOption", "healthRegen"));

  level.matchRules_damageMultiplier = 0;
  level.matchRules_vampirism = 0;

  SetDynamicDvar("scr_game_spectatetype", GetMatchRulesData("commonOption", "spectateModeAllowed"));
  SetDynamicDvar("scr_game_lockspectatorpov", GetMatchRulesData("commonOption", "spectateModePOV"));
  SetDynamicDvar("scr_game_allowkillcam", GetMatchRulesData("commonOption", "showKillcam"));
  SetDynamicDvar("scr_game_forceuav", GetMatchRulesData("commonOption", "radarAlwaysOn"));
  SetDynamicDvar("scr_" + level.gameType + "_playerrespawndelay", GetMatchRulesData("commonOption", "respawnDelay"));
  SetDynamicDvar("scr_" + level.gameType + "_waverespawndelay", GetMatchRulesData("commonOption", "waveRespawnDelay"));
  SetDynamicDvar("scr_player_forcerespawn", GetMatchRulesData("commonOption", "forceRespawn"));

  level.matchRules_allowCustomClasses = GetMatchRulesData("commonOption", "allowCustomClasses");
  level.customClassPickCount = GetMatchRulesData("commonOption", "classPickCount");

  SetDynamicDvar("scr_game_high_jump", GetMatchRulesData("commonOption", "highJump"));
  SetDynamicDvar("jump_slowdownEnable", getDvar("scr_game_high_jump") == "0");

  SetDynamicDvar("scr_game_hardpoints", 1);

  SetDynamicDvar("scr_game_perks", 1);
  SetDynamicDvar("g_hardcore", GetMatchRulesData("commonOption", "hardcoreModeOn"));
  SetDynamicDvar("scr_thirdPerson", GetMatchRulesData("commonOption", "forceThirdPersonView"));
  SetDynamicDvar("camera_thirdPerson", GetMatchRulesData("commonOption", "forceThirdPersonView"));
  SetDynamicDvar("scr_game_onlyheadshots", GetMatchRulesData("commonOption", "headshotsOnly"));
  if(!isDefined(skipFriendlyFire)) {
    SetDynamicDvar("scr_team_fftype", GetMatchRulesData("commonOption", "ffType"));
  }
  SetDynamicDvar("scr_game_killstreakdelay", GetMatchRulesData("commonOption", "streakGracePeriod"));

  level.dynamicEventsType = GetMatchRulesData("commonOption", "dynamicEventsType");
  level.mapStreaksDisabled = GetMatchRulesData("commonOption", "mapStreaksDisabled");
  level.chatterDisabled = GetMatchRulesData("commonOption", "chatterDisabled");
  level.announcerDisabled = GetMatchRulesData("commonOption", "announcerDisabled");
  level.matchRules_switchTeamDisabled = GetMatchRulesData("commonOption", "switchTeamDisabled");
  level.grenadeGracePeriod = GetMatchRulesData("commonOption", "grenadeGracePeriod");

  if(GetMatchRulesData("commonOption", "hardcoreModeOn")) {
    SetDynamicDvar("scr_team_fftype", 1);
    SetDynamicDvar("scr_player_maxhealth", 30);
    SetDynamicDvar("scr_player_healthregentime", 0);
    SetDynamicDvar("scr_player_respawndelay", 10);

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

  if(isDefined(ent)) {
    ent endon("death");
  }

  while(true) {
    level waittill("host_migration_begin");
    if(isDefined(self.lastVisionSetThermal)) {
      self VisionSetThermalForPlayer(self.lastVisionSetThermal, 0);
    }
  }
}

reInitializeDevDvarsOnMigration() {
  level notify("reInitializeDevDvarsOnMigration");
  level endon("reInitializeDevDvarsOnMigration");

  while(1) {
    level waittill("host_migration_begin");

    SetDevDvarIfUninitialized("scr_emp_timeout", 15.0);
    SetDevDvarIfUninitialized("scr_nuke_empTimeout", 60.0);
    SetDevDvarIfUninitialized("scr_remote_turret_timeout", 60.0);
    SetDevDvarIfUninitialized("scr_devchangetimelimit", -1);
  }
}

GetMatchRulesSpecialClass(team, index) {
  class = [];

  class ["loadoutPrimary"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 0, "weapon");
  class ["loadoutPrimaryAttachment"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 0, "attachment", 0);
  class ["loadoutPrimaryAttachment2"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 0, "attachment", 1);
  class ["loadoutPrimaryAttachment3"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 0, "attachment", 2);
  class ["loadoutPrimaryCamo"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 0, "camo");
  class ["loadoutPrimaryReticle"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 0, "reticle");

  class ["loadoutSecondary"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 1, "weapon");
  class ["loadoutSecondaryAttachment"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 1, "attachment", 0);
  class ["loadoutSecondaryAttachment2"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 1, "attachment", 1);
  class ["loadoutSecondaryAttachment3"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 1, "attachment", 2);
  class ["loadoutSecondaryCamo"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 1, "camo");
  class ["loadoutSecondaryReticle"] = getMatchRulesData("defaultClasses", team, index, "class", "weaponSetups", 1, "reticle");

  class ["loadoutEquipment"] = getMatchRulesData("defaultClasses", team, index, "class", "equipmentSetups", 0, "equipment");
  class ["loadoutEquipmentExtra"] = getMatchRulesData("defaultClasses", team, index, "class", "equipmentSetups", 0, "extra");
  class ["loadoutOffhand"] = getMatchRulesData("defaultClasses", team, index, "class", "equipmentSetups", 1, "equipment");
  class ["loadoutOffhandExtra"] = getMatchRulesData("defaultClasses", team, index, "class", "equipmentSetups", 1, "extra");

  for(i = 0; i < 6; i++) {
    class ["loadoutPerks"][i] = getMatchRulesData("defaultClasses", team, index, "class", "perkSlots", i);
  }

  for(i = 0; i < 3; i++) {
    class ["loadoutWildcards"][i] = getMatchRulesData("defaultClasses", team, index, "class", "wildcardSlots", i);
  }

  for(i = 0; i < 4; i++) {
    class ["loadoutKillstreaks"][i] = getMatchRulesData("defaultClasses", team, index, "class", "assaultStreaks", i, "streak");
    for(j = 0; j < 3; j++) {
      class ["loadoutKillstreakModules"][i][j] = getMatchRulesData("defaultClasses", team, index, "class", "assaultStreaks", i, "modules", j);
    }
  }

  class ["loadoutJuggernaut"] = getMatchRulesData("defaultClasses", team, index, "juggernaut");

  return class;
}

recipeClassApplyJuggernaut(removeJuggernaut) {
  level endon("game_ended");
  self endon("disconnect");

  if(!isDefined(level.isHorde)) {
    if(level.inGracePeriod && !self.hasDoneCombat) {
      self waittill("applyLoadout");
    } else {
      self waittill("spawned_player");
    }
  } else {
    self waittill("applyLoadout");
  }

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

  if(!getDvarInt("camera_thirdPerson") && !isDefined(level.isHorde)) {
    self.juggernautOverlay = newClientHudElem(self);
    self.juggernautOverlay.x = 0;
    self.juggernautOverlay.y = 0;
    self.juggernautOverlay.alignX = "left";
    self.juggernautOverlay.alignY = "top";
    self.juggernautOverlay.horzAlign = "fullscreen";
    self.juggernautOverlay.vertAlign = "fullscreen";
    self.juggernautOverlay SetShader(level.juggSettings["juggernaut"].overlay, 640, 480);
    self.juggernautOverlay.sort = -10;
    self.juggernautOverlay.archived = true;
    self.juggernautOverlay.hidein3rdperson = true;
  }

  self thread maps\mp\killstreaks\_juggernaut::juggernautSounds();

  if(level.gameType != "jugg" || (isDefined(level.matchRules_showJuggRadarIcon) && level.matchRules_showJuggRadarIcon)) {
    self setPerk("specialty_radarjuggernaut", true, false);
  }

  if(isDefined(self.isJuggModeJuggernaut) && self.isJuggModeJuggernaut) {
    portable_radar = spawn("script_model", self.origin);
    portable_radar.team = self.team;

    portable_radar makePortableRadar(self);
    self.personalRadar = portable_radar;

    self thread maps\mp\killstreaks\_juggernaut::radarMover(portable_radar);
  }

  level notify("juggernaut_equipped", self);

  self thread maps\mp\killstreaks\_juggernaut::juggRemover();
}

updateSessionState(sessionState) {
  assert(sessionState == "playing" || sessionState == "dead" || sessionState == "spectator" || sessionState == "intermission");
  self.sessionstate = sessionState;
  self SetClientOmnvar("ui_session_state", sessionState);
}

cac_getCustomClassLoc() {
  if(isDefined(level.forceCustomClassLoc)) {
    return level.forceCustomClassLoc;
  }

  if(GetDvarInt("xblive_privatematch") || (IsSystemLink())) {
    return "privateMatchCustomClasses";
  } else {
    return "customClasses";
  }
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
  if(IsAgent(ent) && ent.agent_teamParticipant == true) {
    return true;
  }

  if(IsBot(ent)) {
    return true;
  }

  return false;
}

IsTeamParticipant(ent) {
  if(IsAITeamParticipant(ent)) {
    return true;
  }

  if(isPlayer(ent)) {
    return true;
  }

  return false;
}

IsAIGameParticipant(ent) {
  if(IsAgent(ent) && ent.agent_gameParticipant == true) {
    return true;
  }

  if(IsBot(ent)) {
    return true;
  }

  return false;
}

IsGameParticipant(ent) {
  if(IsAIGameParticipant(ent)) {
    return true;
  }

  if(isPlayer(ent)) {
    return true;
  }

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

isMeleeMOD(sMeansOfDeath) {
  return sMeansOfDeath == "MOD_MELEE" || sMeansOfDeath == "MOD_MELEE_ALT";
}

isHeadShot(sWeapon, sHitLoc, sMeansOfDeath, attacker) {
  if(isDefined(attacker)) {
    if(isDefined(attacker.owner)) {
      if(attacker.code_classname == "script_vehicle") {
        return false;
      }
      if(attacker.code_classname == "misc_turret") {
        return false;
      }
      if(attacker.code_classname == "script_model") {
        return false;
      }
    }
    if(isDefined(attacker.agent_type)) {
      if(attacker.agent_type == "dog" || attacker.agent_type == "alien") {
        return false;
      }
    }
  }

  return (sHitLoc == "head" || sHitLoc == "helmet") && !isMeleeMOD(sMeansOfDeath) && sMeansOfDeath != "MOD_IMPACT" && !isEnvironmentWeapon(sWeapon);
}

attackerIsHittingTeam(victim, attacker) {
  if(!level.teamBased) {
    return false;
  } else if(!isDefined(attacker) || !isDefined(victim)) {
    return false;
  } else if(!isDefined(victim.team) || !isDefined(attacker.team)) {
    return false;
  } else if(victim == attacker) {
    return false;
  } else if(victim.pers["team"] == attacker.team && isDefined(attacker.teamChangedThisFrame)) {
    return false;
  } else if(isDefined(attacker.scrambled) && attacker.scrambled) {
    return false;
  } else if(victim.team == attacker.team) {
    return true;
  } else {
    return false;
  }
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

get_rank_xp_and_prestige_for_bot() {
  if(isDefined(level.bot_funcs["bot_get_rank_xp_and_prestige"])) {
    return self[[level.bot_funcs["bot_get_rank_xp_and_prestige"]]]();
  }
}

set_rank_xp_and_prestige_for_bot() {
  rank_values = self get_rank_xp_and_prestige_for_bot();
  if(isDefined(rank_values)) {
    self.pers["rankxp"] = rank_values.rankxp;
    self.pers["prestige"] = rank_values.prestige;
    self.pers["prestige_fake"] = rank_values.prestige;
  }
}

set_console_status() {
  if(!isDefined(level.Console)) {
    level.Console = getDvar("consoleGame") == "true";
  } else {
    AssertEx(level.Console == (getDvar("consoleGame") == "true"), "Level.console got set incorrectly.");
  }

  if(!isDefined(level.xenon)) {
    level.xenon = getDvar("xenonGame") == "true";
  } else {
    AssertEx(level.xenon == (getDvar("xenonGame") == "true"), "Level.xenon got set incorrectly.");
  }

  if(!isDefined(level.ps3)) {
    level.ps3 = getDvar("ps3Game") == "true";
  } else {
    AssertEx(level.ps3 == (getDvar("ps3Game") == "true"), "Level.ps3 got set incorrectly.");
  }

  if(!isDefined(level.xb3)) {
    level.xb3 = getDvar("xb3Game") == "true";
  } else {
    AssertEx(level.xb3 == (getDvar("xb3Game") == "true"), "Level.xb3 got set incorrectly.");
  }

  if(!isDefined(level.ps4)) {
    level.ps4 = getDvar("ps4Game") == "true";
  } else {
    AssertEx(level.ps4 == (getDvar("ps4Game") == "true"), "Level.ps4 got set incorrectly.");
  }
}

is_gen4() {
  AssertEx(isDefined(level.Console) && isDefined(level.xb3) && isDefined(level.ps4), "is_gen4() called before set_console_status() has been run.");

  if(level.xb3 || level.ps4 || !level.console) {
    return true;
  } else {
    return false;
  }
}

setdvar_cg_ng(dvar_name, current_gen_val, next_gen_val) {
  if(!isDefined(level.console) || !isDefined(level.xb3) || !isDefined(level.ps4)) {
    set_console_status();
  }
  AssertEx(isDefined(level.console) && isDefined(level.xb3) && isDefined(level.ps4), "Expected platform defines to be complete.");

  if(is_gen4()) {
    setDvar(dvar_name, next_gen_val);
  } else {
    setDvar(dvar_name, current_gen_val);
  }
}

isValidTeamTarget(attacker, target) {
  return (isDefined(target.team) && target.team != attacker.team);
}

isValidFFATarget(attacker, target) {
  return (isDefined(target.owner) && target.owner != attacker);
}

getHeliPilotMeshOffset() {
  return (0, 0, 5000);
}

getHeliPilotTraceOffset() {
  return (0, 0, 2500);
}

revertVisionSetForPlayer(time) {
  AssertEx(isPlayer(self), "revertVisionSetForPlayer() called on a non player entity");

  if(!isDefined(time)) {
    time = 1;
  }
  if(isDefined(level.nukeDetonated) && isDefined(level.nukeVisionSet)) {
    self SetClientTriggerVisionSet(level.nukeVisionSet, time);
    self VisionSetNakedForPlayer(level.nukeVisionSet, time);
    self set_visionset_for_watching_players(level.nukeVisionSet, time);
  } else if(isDefined(self.usingRemote) && isDefined(self.rideVisionSet)) {
    self SetClientTriggerVisionSet(self.rideVisionSet, time);
    self VisionSetNakedForPlayer(self.rideVisionSet, time);
    self set_visionset_for_watching_players(self.rideVisionSet, time);
  } else {
    self SetClientTriggerVisionSet("", time);
    self VisionSetNakedForPlayer("", time);
    self set_visionset_for_watching_players("", time);
  }
}

set_light_set_for_player(lightset) {
  if(!isPlayer(self)) {
    return;
  }

  if(isDefined(level.lightset_current)) {
    level.lightset_previous = level.lightset_current;
  }

  level.lightset_current = lightset;
  self LightSetForPlayer(lightset);
}

clear_light_set_for_player() {
  if(!isPlayer(self)) {
    return;
  }

  lightset = GetMapCustom("map");

  if(isDefined(level.lightset_previous)) {
    lightset = level.lightset_previous;
    level.lightset_previous = undefined;
  }

  level.lightset_current = lightset;
  self LightSetForPlayer(lightset);
}

light_set_override_for_player(lightset_name, enable_duration, lightset_duration, disable_duration) {
  if(!isPlayer(self)) {
    return;
  }

  self LightSetOverrideEnableForPlayer(lightset_name, enable_duration);
  self waitForTimeOrNotifies(lightset_duration, ["death", "disconnect"]);
  if(isDefined(self)) {
    self LightSetOverrideDisableForPlayer(disable_duration);
  }
}

getUniqueId() {
  if(isDefined(self.pers["guid"])) {
    return self.pers["guid"];
  }

  playerGuid = self getGuid();
  if(playerGuid == "0000000000000000") {
    if(isDefined(level.guidGen)) {
      level.guidGen++;
    } else {
      level.guidGen = 1;
    }

    playerGuid = "script" + level.guidGen;
  }

  self.pers["guid"] = playerGuid;

  return self.pers["guid"];
}

get_players_watching(just_spectators, just_killcam) {
  if(!isDefined(just_spectators)) {
    just_spectators = false;
  }
  if(!isDefined(just_killcam)) {
    just_killcam = false;
  }

  entity_num_self = self GetEntityNumber();
  players_watching = [];
  foreach(player in level.players) {
    if(!isDefined(player) || player == self) {
      continue;
    }

    player_is_watching = false;

    if(!just_killcam) {
      if((isDefined(player.team) && player.team == "spectator") || player.sessionstate == "spectator") {
        spectatingPlayer = player GetSpectatingPlayer();
        if(isDefined(spectatingPlayer) && spectatingPlayer == self) {
          player_is_watching = true;
        }
      }

      if(player.forcespectatorclient == entity_num_self) {
        player_is_watching = true;
      }
    }

    if(!just_spectators) {
      if(player.killcamentity == entity_num_self) {
        player_is_watching = true;
      }
    }

    if(player_is_watching) {
      players_watching[players_watching.size] = player;
    }
  }

  return players_watching;
}

set_visionset_for_watching_players(new_visionset, new_visionset_transition_time, time_in_new_visionset, is_missile_visionset, just_spectators, just_killcam, is_apply_visionset) {
  players_watching = self get_players_watching(just_spectators, just_killcam);
  foreach(player in players_watching) {
    player notify("changing_watching_visionset");
    if(isDefined(is_missile_visionset) && is_missile_visionset) {
      player VisionSetMissilecamForPlayer(new_visionset, new_visionset_transition_time);
    } else if(isDefined(is_apply_visionset) && is_apply_visionset) {
      player VisionSetPostApplyForPlayer(new_visionset, new_visionset_transition_time);
    } else {
      player VisionSetNakedForPlayer(new_visionset, new_visionset_transition_time);
    }
    if(new_visionset != "" && isDefined(time_in_new_visionset)) {
      player thread reset_visionset_on_team_change(self, new_visionset_transition_time + time_in_new_visionset, is_apply_visionset);
      player thread reset_visionset_on_disconnect(self, is_apply_visionset);

      if(player isInKillcam()) {
        player thread reset_visionset_on_spawn();
      }
    }
  }
}

reset_visionset_on_spawn() {
  self endon("disconnect");

  self waittill("spawned");
  self VisionSetNakedForPlayer("", 0.0);
  self VisionSetPostApplyForPlayer("", 0.0);
}

reset_visionset_on_team_change(current_player_watching, time_till_default_visionset, is_apply_visionset) {
  self endon("changing_watching_visionset");
  current_player_watching endon("disconnect");

  time_started = GetTime();
  team_started = self.team;
  while(GetTime() - time_started < time_till_default_visionset * 1000) {
    if(self.team != team_started || !array_contains(current_player_watching get_players_watching(), self)) {
      if(isDefined(is_apply_visionset) && is_apply_visionset) {
        self VisionSetPostApplyForPlayer("", 0.0);
      } else {
        self VisionSetNakedForPlayer("", 0.0);
      }
      self notify("changing_visionset");
      break;
    }

    wait(0.05);
  }
}

reset_visionset_on_disconnect(entity_watching, is_apply_visionset) {
  self endon("changing_watching_visionset");
  entity_watching waittill("disconnect");
  if(isDefined(is_apply_visionset) && is_apply_visionset) {
    self VisionSetPostApplyForPlayer("", 0.0);
  } else {
    self VisionSetNakedForPlayer("", 0.0);
  }
}

_validateAttacker(eAttacker) {
  if(IsAgent(eAttacker) && (!isDefined(eAttacker.isActive) || !eAttacker.isActive)) {
    return undefined;
  }

  return eAttacker;
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

#using_animtree("animated_props");
FindAndPlayAnims(name, bOffset) {
  AnimatedPropArray = getEntArray(name, "targetname");
  if(AnimatedPropArray.size > 0) {
    foreach(prop in AnimatedPropArray) {
      bDelta = false;
      if(isDefined(prop.script_animation)) {
        if(isDefined(prop.script_parameters) && prop.script_parameters == "delta_anim") {
          bDelta = true;
        }
        prop thread PlayAnim(bOffset, bDelta);
      }
    }
  }
}
PlayAnim(bOffset, bDelta) {
  if(bOffset == true) {
    wait(RandomFloatRange(0.0, 1));
  }

  if(bDelta == false) {
    self ScriptModelPlayAnim(self.script_animation);
  } else {
    self ScriptModelPlayAnimDeltaMotion(self.script_animation);
  }
}

playerAllowHighJump(enable, type) {
  self _playerAllow("highjump", enable, type, ::AllowHighJump);
}

playerAllowHighJumpDrop(enable, type) {
  self _playerAllow("highjumpdrop", enable, type, ::AllowHighJumpDrop);
}

playerAllowBoostJump(enable, type) {
  self _playerAllow("boostjump", enable, type, ::AllowBoostJump);
}

playerAllowPowerSlide(enable, type) {
  self _playerAllow("powerslide", enable, type, ::AllowPowerSlide);
}

playerAllowDodge(enable, type) {
  self _playerAllow("dodge", enable, type, ::AllowDodge);
}

_playerAllow(ability, enable, type, enableFunc, isBuiltinFunc) {
  if(!isDefined(self.playerDisableAbilityTypes)) {
    self.playerDisableAbilityTypes = [];
  }

  if(!isDefined(self.playerDisableAbilityTypes[ability])) {
    self.playerDisableAbilityTypes[ability] = [];
  }

  if(!isDefined(type)) {
    type = "default";
  }

  if(!isDefined(isBuiltinFunc)) {
    isBuiltinFunc = true;
  }

  if(enable) {
    self.playerDisableAbilityTypes[ability] = array_remove(self.playerDisableAbilityTypes[ability], type);
    if(!self.playerDisableAbilityTypes[ability].size) {
      if(isBuiltinFunc) {
        self call[[enableFunc]](true);
      } else {
        self[[enableFunc]](true);
      }
    }
  } else {
    if(!isDefined(array_find(self.playerDisableAbilityTypes[ability], type))) {
      self.playerDisableAbilityTypes[ability] = array_add(self.playerDisableAbilityTypes[ability], type);
    }

    if(isBuiltinFunc) {
      self call[[enableFunc]](false);
    } else {
      self[[enableFunc]](false);
    }
  }
}

makeGloballyUsableByType(type, hintString, player, team) {
  Assert(!isDefined(player) || !isDefined(team));

  priority = 500;

  switch (type) {
    case "killstreakRemote":
      priority = 300;
      break;
    case "coopStreakPrompt":
      priority = 301;
      break;
    default:
      AssertMsg("makeGloballyUsableByType(): type <" + type + "> is not defined; valid options are coopStreakPrompt &killstreakRemote (or add it if needed)");
      break;
  }

  _insertIntoGlobalUsableList(priority, type, player, team);

  self MakeGlobalUsable(priority, player, team);
  self SetHintString(hintString);
  self SetCursorHint("HINT_NOICON");
}

_insertIntoGlobalUsableList(priority, type, player, team) {
  if(!isDefined(level.globalUsableEnts)) {
    level.globalUsableEnts = [];
  }

  firstIndex = -1;
  for(i = 0; i < level.globalUsableEnts.size; i++) {
    nextEntStruct = level.globalUsableEnts[i];
    if(nextEntStruct.priority > priority) {
      if(firstIndex == -1) {
        firstIndex = i;
      }
      break;
    }

    if(nextEntStruct.priority == priority) {
      nextEntStruct.priority += 0.01;
      if(nextEntStruct.enabled) {
        nextEntStruct.ent MakeGlobalUsable(nextEntStruct.priority, nextEntStruct.player, nextEntStruct.team);
      }

      if(firstIndex == -1) {
        firstIndex = i;
      }
    }
  }

  if(firstIndex == -1) {
    firstIndex = 0;
  }

  entStruct = spawnStruct();
  entStruct.ent = self;
  entStruct.priority = priority;
  entStruct.type = type;
  entStruct.player = player;
  entStruct.team = team;
  entStruct.enabled = true;

  level.globalUsableEnts = array_insert(level.globalUsableEnts, entStruct, firstIndex);
}

makeGloballyUnusableByType() {
  foundEnt = undefined;
  foreach(entStruct in level.globalUsableEnts) {
    if(entStruct.ent == self) {
      foundEnt = entStruct;
      break;
    }
  }

  if(isDefined(foundEnt)) {
    foundEntPriority = foundEnt.priority;
    level.globalUsableEnts = array_remove(level.globalUsableEnts, foundEnt);
    self MakeGlobalUnusable();

    foreach(entStruct in level.globalUsableEnts) {
      if(foundEntPriority > entStruct.priority && (Int(foundEntPriority) == Int(entStruct.priority))) {
        entStruct.priority -= 0.01;
        if(entStruct.enabled) {
          entStruct.ent MakeGlobalUsable(entStruct.priority, entStruct.player, entStruct.team);
        }
      }
    }
  }
}

disableGloballyUsableByType() {
  foreach(entStruct in level.globalUsableEnts) {
    if(entStruct.ent == self) {
      if(entStruct.enabled) {
        entStruct.ent MakeGlobalUnusable();
        entStruct.enabled = false;
      }
      break;
    }
  }
}

enableGloballyUsableByType() {
  foreach(entStruct in level.globalUsableEnts) {
    if(entStruct.ent == self) {
      if(!entStruct.enabled) {
        entStruct.ent MakeGlobalUsable(entStruct.priority, entStruct.player, entStruct.team);
        entStruct.enabled = true;
      }
      break;
    }
  }
}

setDOF(DOFset) {
  self setdepthoffield(DOFset["nearStart"], DOFset["nearEnd"], DOFset["farStart"], DOFset["farEnd"], DOFset["nearBlur"], DOFset["farBlur"]);
}

is_exo_ability_weapon(weapon_name) {
  switch (weapon_name) {
    case "adrenaline_mp":
    case "extra_health_mp":
    case "exocloak_equipment_mp":
    case "exohover_equipment_mp":
    case "exoping_equipment_mp":
    case "exorepulsor_equipment_mp":
    case "exoshield_equipment_mp":
    case "exoshieldhorde_equipment_mp":
    case "exohoverhorde_equipment_mp":
    case "exocloakhorde_equipment_mp":
    case "exomute_equipment_mp":
      return true;
    default:
      return false;
  }
}

isEnemy(potentialEnemy) {
  if(level.teamBased) {
    return self isPlayerOnEnemyTeam(potentialEnemy);
  } else {
    return self isPlayerFFAEnemy(potentialEnemy);
  }
}

isPlayerOnEnemyTeam(potentialEnemy) {
  return (potentialEnemy.team != self.team);
}

isPlayerFFAEnemy(potentialEnemy) {
  if(isDefined(potentialEnemy.owner)) {
    return (potentialEnemy.owner != self);
  } else {
    return (potentialEnemy != self);
  }
}

isMLGSystemLink() {
  if((IsSystemLink() && GetDvarInt("xblive_competitionmatch"))) {
    return true;
  }

  return false;
}

isMLGSplitScreen() {
  if((IsSplitScreen() && GetDvarInt("xblive_competitionmatch"))) {
    return true;
  }

  return false;
}

isMLGPrivateMatch() {
  if((privateMatch() && GetDvarInt("xblive_competitionmatch"))) {
    return true;
  }

  return false;
}

isMLGMatch() {
  if(isMLGSystemLink() || isMLGSplitScreen() || isMLGPrivateMatch()) {
    return true;
  }

  return false;
}

spawnFXShowToTeam(fxId, team, origin, fwd) {
  fx = SpawnFX(fxId, origin, fwd);
  fx fxShowToTeam(team);

  return fx;
}

fxShowToTeam(team) {
  self thread showFXToTeam(team);
  SetFXKillOnDelete(self, true);
  TriggerFX(self);
}

showFXToTeam(team) {
  self endon("death");
  level endon("game_ended");

  while(true) {
    self Hide();
    foreach(player in level.players) {
      playerTeam = player.team;
      if(playerTeam != "axis" || player IsMLGSpectator()) {
        playerTeam = "allies";
      }

      if((team == playerTeam) || (team == "neutral")) {
        self ShowToPlayer(player);
      }
    }

    level waittill("joined_team");
  }
}

get_spawn_weapon_name(loadout) {
  weapon_name = "iw5_combatknife_mp";

  if(isDefined(loadout.primaryName) && (loadout.primaryName != "none") && (loadout.primaryName != "iw5_combatknife_mp")) {
    weapon_name = loadout.primaryName;
  } else if(isDefined(loadout.secondaryName) && (loadout.secondaryName != "none")) {
    weapon_name = loadout.secondaryName;
  }

  return weapon_name;
}

playerSaveAngles() {
  self.restoreAngles = self GetPlayerAngles();
}

playerRestoreAngles() {
  if(isDefined(self.restoreAngles)) {
    if(self.team != "spectator") {
      self SetPlayerAngles(self.restoreAngles);
    }
    self.restoreAngles = undefined;
  }
}

setMLGIcons(object, icon) {
  object maps\mp\gametypes\_gameobjects::set2DIcon("mlg", icon);
  object maps\mp\gametypes\_gameobjects::set3DIcon("mlg", icon);
}

spawnPatchClip(name, clip_origin, clip_angles) {
  copy_ent = GetEnt(name, "targetname");
  if(!isDefined(copy_ent)) {
    return undefined;
  }

  clip = spawn("script_model", clip_origin);
  clip CloneBrushmodelToScriptmodel(copy_ent);
  clip.angles = clip_angles;

  return clip;
}

isCOOP() {
  if(isDefined(level.isHorde) && level.isHorde) {
    return true;
  }

  if(isDefined(level.isZombieGame) && level.isZombieGame) {
    return true;
  }

  return false;
}