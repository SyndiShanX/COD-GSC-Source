/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\mp\_ambientpackage.csc
*****************************************************/

#include clientscripts\mp\_utility;

init() {
  level.activeAmbientPackage = "";
  level.ambientPackages = [];
  level.ambientNumMissedSounds = 0;
  level.ambientNumSeqMissedSounds = 0;
  thread updateActiveAmbientPackage();
  level.ambientPackageScriptOriginPool = [];
  for (i = 0; i < 5; i++) {
    level.ambientPackageScriptOriginPool[i] = spawnStruct();
    level.ambientPackageScriptOriginPool[i].org = spawnfakeent(0);
    level.ambientPackageScriptOriginPool[i].inuse = false;
    level.ambientPackageScriptOriginPool[i] thread scriptOriginPoolThread();
  }
  level.activeAmbientRoom = "";
  level.ambientRoomToneOriginPool = [];
  level.ambientRoomToneOriginPoolIndex = 0;
  for (i = 0; i < 5; i++) {
    level.ambientRoomToneOriginPool[i] = spawnStruct();
    level.ambientRoomToneOriginPool[i].org = spawnfakeent(0);
    level.ambientRoomToneOriginPool[i].inuse = false;
    level.ambientRoomToneOriginPool[i].alias = "";
  }
  level.ambientRooms = [];
  level thread updateActiveAmbientRoom();
  clientscripts\mp\_utility::registerSystem("ambientPackageCmd", ::ambientPackageCmdHandler);
  clientscripts\mp\_utility::registerSystem("ambientRoomCmd", ::ambientRoomCmdHandler);
}

declareAmbientPackage(package) {
  if(isDefined(level.ambientPackages[package])) {
    return;
  }
  level.ambientPackages[package] = spawnStruct();
  level.ambientPackages[package].priority = [];
  level.ambientPackages[package].refcount = [];
  level.ambientPackages[package].elements = [];
}

addAmbientElement(package, alias, spawnMin, spawnMax, distMin, distMax, angleMin, angleMax) {
  if(!isDefined(level.ambientPackages[package])) {
    assertmsg("addAmbientElement: must declare ambient package \"" + package + "\" in level_amb main before it can have elements added to it");
    return;
  }
  index = level.ambientPackages[package].elements.size;
  level.ambientPackages[package].elements[index] = spawnStruct();
  level.ambientPackages[package].elements[index].alias = alias;
  if(spawnMin < 0)
    spawnMin = 0;
  if(spawnMin >= spawnMax)
    spawnMax = spawnMin + 1;
  level.ambientPackages[package].elements[index].spawnMin = spawnMin;
  level.ambientPackages[package].elements[index].spawnMax = spawnMax;
  level.ambientPackages[package].elements[index].distMin = -1;
  level.ambientPackages[package].elements[index].distMax = -1;
  if(isDefined(distMin) && isDefined(distMax) && distMin >= 0 && distMin < distMax) {
    level.ambientPackages[package].elements[index].distMin = distMin;
    level.ambientPackages[package].elements[index].distMax = distMax;
  }
  level.ambientPackages[package].elements[index].angleMin = 0;
  level.ambientPackages[package].elements[index].angleMax = 359;
  if(isDefined(angleMin) && isDefined(angleMax) && angleMin >= 0 && angleMin < angleMax && angleMax <= 720) {
    level.ambientPackages[package].elements[index].angleMin = angleMin;
    level.ambientPackages[package].elements[index].angleMax = angleMax;
  }
}

declareAmbientRoom(room) {
  if(isDefined(level.ambientRooms[room])) {
    return;
  }
  level.ambientRooms[room] = spawnStruct();
  level.ambientRooms[room].priority = [];
  level.ambientRooms[room].refcount = [];
}

setAmbientRoomTone(room, alias, fadeIn, fadeOut) {
  if(!isDefined(level.ambientRooms[room])) {
    assertmsg("setAmbientRoomTone: must declare ambient room \"" + room + "\" in level_amb main before it can have a room tone set");
    return;
  }
  level.ambientRooms[room].tone = alias;
  level.ambientRooms[room].fadeIn = 2;
  if(isDefined(fadeIn) && fadeIn >= 0) {
    level.ambientRooms[room].fadeIn = fadeIn;
  }
  level.ambientRooms[room].fadeOut = 2;
  if(isDefined(fadeOut) && fadeOut >= 0) {
    level.ambientRooms[room].fadeOut = fadeOut;
  }
}

setAmbientRoomReverb(room, reverbRoomType, dry, wet, fade) {
  if(!isDefined(level.ambientRooms[room])) {
    assertmsg("setAmbientRoomReverb: must declare ambient room \"" + room + "\" in level_amb main before it can have a room reverb set");
    return;
  }
  level.ambientRooms[room].reverb = spawnStruct();
  level.ambientRooms[room].reverb.reverbRoomType = reverbRoomType;
  level.ambientRooms[room].reverb.dry = dry;
  level.ambientRooms[room].reverb.wet = wet;
  level.ambientRooms[room].reverb.fade = 2;
  if(isDefined(fade) && fade >= 0) {
    level.ambientRooms[room].reverb.fade = fade;
  }
}

activateAmbientPackage(clientNum, package, priority) {
  if(!isDefined(level.ambientPackages[package])) {
    assertmsg("activateAmbientPackage: must declare ambient package \"" + package + "\" in level_amb.csc main before it can be activated");
    return;
  }
  for (i = 0; i < level.ambientPackages[package].priority.size; i++) {
    if(level.ambientPackages[package].priority[i] == priority) {
      level.ambientPackages[package].refcount[i]++;
      break;
    }
  }
  if(i == level.ambientPackages[package].priority.size) {
    level.ambientPackages[package].priority[i] = priority;
    level.ambientPackages[package].refcount[i] = 1;
  }
  level notify("updateActiveAmbientPackage");
}

activateAmbientRoom(clientNum, room, priority) {
  if(!isDefined(level.ambientRooms[room])) {
    assertmsg("activateAmbientRoom: must declare ambient room \"" + room + "\" in level_amb.csc main before it can be activated");
    return;
  }
  for (i = 0; i < level.ambientRooms[room].priority.size; i++) {
    if(level.ambientRooms[room].priority[i] == priority) {
      level.ambientRooms[room].refcount[i]++;
      break;
    }
  }
  if(i == level.ambientRooms[room].priority.size) {
    level.ambientRooms[room].priority[i] = priority;
    level.ambientRooms[room].refcount[i] = 1;
  }
  level notify("updateActiveAmbientRoom");
}

ambientPackageCmdHandler(clientNum, state, oldState) {
  if(state != "") {
    split_state = splitargs(state);
    if(split_state.size != 3) {
      println("*** Client : Malformed arguements to ambient packages " + state);
    } else {
      command = split_state[0];
      package = split_state[1];
      priority = int(split_state[2]);
      if(command == "A") {
        if(!isDefined(level.ambientPackages[package])) {
          assertmsg("activateAmbientPackage: must declare ambient package \"" + package + "\" in level_amb.csc main before it can be activated");
          return;
        }
        for (i = 0; i < level.ambientPackages[package].priority.size; i++) {
          if(level.ambientPackages[package].priority[i] == priority) {
            level.ambientPackages[package].refcount[i]++;
            break;
          }
        }
        if(i == level.ambientPackages[package].priority.size) {
          level.ambientPackages[package].priority[i] = priority;
          level.ambientPackages[package].refcount[i] = 1;
        }
        level notify("updateActiveAmbientPackage");
      } else if(command == "D") {
        if(!isDefined(level.ambientPackages[package])) {
          assertmsg("deactivateAmbientPackage: must declare ambient package \"" + package + "\" in level_amb.csc main before it can be deactivated");
          return;
        }
        for (i = 0; i < level.ambientPackages[package].priority.size; i++) {
          if(level.ambientPackages[package].priority[i] == priority && level.ambientPackages[package].refcount[i]) {
            level.ambientPackages[package].refcount[i]--;

            level notify("updateActiveAmbientPackage");
            return;
          }
        }
      } else {
        assertmsg("Unknown command in ambientPackageCmdHandler " + state);
        return;
      }
    }
  }
}

ambientRoomCmdHandler(clientNum, state, oldState) {
  if(state != "") {
    split_state = splitargs(state);
    if(split_state.size != 3) {
      println("*** Client : Malformed arguements to ambient packages " + state);
    } else {
      command = split_state[0];
      room = split_state[1];
      priority = int(split_state[2]);
      if(command == "A") {
        if(!isDefined(level.ambientRooms[room])) {
          assertmsg("activateAmbientRoom: must declare ambient room \"" + room + "\" in level_amb.csc main before it can be activated");
          return;
        }
        for (i = 0; i < level.ambientRooms[room].priority.size; i++) {
          if(level.ambientRooms[room].priority[i] == priority) {
            level.ambientRooms[room].refcount[i]++;
            break;
          }
        }
        if(i == level.ambientRooms[room].priority.size) {
          level.ambientRooms[room].priority[i] = priority;
          level.ambientRooms[room].refcount[i] = 1;
        }

        level notify("updateActiveAmbientRoom");
      } else if(command == "D") {
        if(!isDefined(level.ambientRooms[room])) {
          assertmsg("deactivateAmbientRoom: must declare ambient room \"" + room + "\" in level_amb.csc main before it can be deactivated");
          return;
        }
        for (i = 0; i < level.ambientRooms[room].priority.size; i++) {
          if(level.ambientRooms[room].priority[i] == priority && level.ambientRooms[room].refcount[i]) {
            level.ambientRooms[room].refcount[i]--;

            level notify("updateActiveAmbientRoom");
            return;
          }
        }
      } else {
        assertmsg("Unknown command in ambientRoomCmdHandler " + state);
        return;
      }
    }
  }
}

ambientElementThread() {
  level endon("killambientElementThread" + level.activeAmbientPackage);
  timer = 0;
  if(self.distMin < 0) {
    for (;;) {
      timer = randomfloatrange(self.spawnMin, self.spawnMax);
      wait timer;
      if(getdvarint("debug_audio") > 0) {
        iprintlnbold("AP : playing2d: " + self.alias);
      }
      playLocalSound(0, self.alias);
    }
  } else {
    dist = 0;
    angle = 0;
    offset = (0, 0, 0);
    index = -1;
    for (;;) {
      timer = randomfloatrange(self.spawnMin, self.spawnMax);
      wait timer;
      index = getScriptOriginPoolIndex();
      if(index >= 0) {
        dist = randomintrange(self.distMin, self.distMax);
        angle = randomintrange(self.angleMin, self.angleMax);
        player_angle = getlocalclientangles(0)[1];
        offset = anglestoforward((0, angle + player_angle, 0));
        offset = vectorscale(offset, dist);
        pos = getlocalclienteyepos(0) + offset;
        setfakeentorg(0, level.ambientPackageScriptOriginPool[index].org, pos);
        level.ambientPackageScriptOriginPool[index].soundId = playSound(0, self.alias, pos);
        if(getdvarint("debug_audio") > 0) {
          if(level.ambientPackageScriptOriginPool[index].soundId == -1) {
            col = (0.8, 0.0, 0.0);
          } else {
            col = (0.0, 0.8, 0.0);
          }
          print3d(pos, "AP : " + self.alias, col, 1, 3, 30);
        }
        while (level.ambientPackageScriptOriginPool[index].soundId != -1) {
          wait(0.01);
        }
      }
    }
  }
}

getScriptOriginPoolIndex() {
  for (index = 0; index < level.ambientPackageScriptOriginPool.size; index++) {
    if(!level.ambientPackageScriptOriginPool[index].inuse) {
      level.ambientPackageScriptOriginPool[index].inuse = true;
      level.ambientNumSeqMissedSounds = 0;
      return index;
    }
  }
  level.ambientNumMissedSounds++;
  level.ambientNumSeqMissedSounds++;
  if(getdvarint("debug_audio") > 0) {
    iprintlnbold("No free origins " + level.ambientNumSeqMissedSounds + " ( " + level.ambientNumMissedSounds + " )");
  }
  return -1;
}

scriptOriginPoolThread() {
  for (;;) {
    if(self.inuse == true) {
      if(isDefined(self.soundId)) {
        if(self.SoundId != -1) {
          if(!SoundPlaying(self.soundId)) {
            self.inuse = false;
            self.soundId = -1;
          }
        } else {
          self.inUse = false;
        }
      }
    }
    wait(0.01);
  }
}

findHighestPriorityAmbientPackage() {
  package = "";
  priority = -1;
  packageArray = getArrayKeys(level.ambientPackages);
  for (i = 0; i < packageArray.size; i++) {
    for (j = 0; j < level.ambientPackages[packageArray[i]].priority.size; j++) {
      if(level.ambientPackages[packageArray[i]].refcount[j] && level.ambientPackages[packageArray[i]].priority[j] > priority) {
        package = packageArray[i];
        priority = level.ambientPackages[packageArray[i]].priority[j];
      }
    }
  }
  return package;
}

updateActiveAmbientPackage() {
  for (;;) {
    level waittill("updateActiveAmbientPackage");
    newAmbientPackage = findHighestPriorityAmbientPackage();
    if(newAmbientPackage != "" && level.activeAmbientPackage != newAmbientPackage) {
      level notify("killambientElementThread" + level.activeAmbientPackage);
      level.activeAmbientPackage = newAmbientPackage;
      array_thread(level.ambientPackages[level.activeAmbientPackage].elements, ::ambientElementThread);
    }
  }
}

roomToneFadeOutTimerThread(fadeOut) {
  self endon("killRoomToneFadeOutTimer");
  wait fadeOut;
  self.inuse = false;
}

findHighestPriorityAmbientRoom() {
  room = "";
  priority = -1;
  roomArray = getArrayKeys(level.ambientRooms);
  if(isDefined(roomArray)) {
    for (i = 0; i < roomArray.size; i++) {
      for (j = 0; j < level.ambientRooms[roomArray[i]].priority.size; j++) {
        if(level.ambientRooms[roomArray[i]].refcount[j]) {}
        if(level.ambientRooms[roomArray[i]].refcount[j] && level.ambientRooms[roomArray[i]].priority[j] > priority) {
          room = roomArray[i];
          priority = level.ambientRooms[roomArray[i]].priority[j];
        }
      }
    }
  }
  return room;
}

updateActiveAmbientRoom() {
  org = (0, 0, 0);
  for (;;) {
    level waittill("updateActiveAmbientRoom");
    newAmbientRoom = findHighestPriorityAmbientRoom();
    if(newAmbientRoom != "" && level.activeAmbientRoom != newAmbientRoom) {
      if(level.activeAmbientRoom != "" && isDefined(level.ambientRooms[level.activeAmbientRoom].tone)) {
        for (i = 0; i < level.ambientRoomToneOriginPool.size; i++) {
          if(level.ambientRoomToneOriginPool[i].inuse && level.ambientRoomToneOriginPool[i].alias == level.ambientRooms[level.activeAmbientRoom].tone) {

            stopLoopSound(0, level.ambientRoomToneOriginPool[i].org, level.ambientRooms[level.activeAmbientRoom].fadeOut);
            level.ambientRoomToneOriginPool[i] thread roomToneFadeOutTimerThread(level.ambientRooms[level.activeAmbientRoom].fadeOut);
            break;
          }
        }
      }
      level.activeAmbientRoom = newAmbientRoom;
      if(isDefined(level.ambientRooms[level.activeAmbientRoom].tone)) {
        for (i = 0; i < level.ambientRoomToneOriginPool.size; i++) {
          if(level.ambientRoomToneOriginPool[i].inuse && level.ambientRoomToneOriginPool[i].alias == level.ambientRooms[level.activeAmbientRoom].tone) {
            org = level.ambientRoomToneOriginPool[i].org;
            level.ambientRoomToneOriginPool[i] notify("killRoomToneFadeOutTimer");
            break;
          }
        }
        if(i == level.ambientRoomToneOriginPool.size) {
          level.ambientRoomToneOriginPoolIndex++;
          if(level.ambientRoomToneOriginPool.size == level.ambientRoomToneOriginPoolIndex) {
            level.ambientRoomToneOriginPoolIndex = 0;
          }
          org = level.ambientRoomToneOriginPool[level.ambientRoomToneOriginPoolIndex].org;
          level.ambientRoomToneOriginPool[level.ambientRoomToneOriginPoolIndex].alias = level.ambientRooms[level.activeAmbientRoom].tone;
          level.ambientRoomToneOriginPool[level.ambientRoomToneOriginPoolIndex].inuse = true;
        }
        playLoopSound(0, org, level.ambientRooms[level.activeAmbientRoom].tone, level.ambientRooms[level.activeAmbientRoom].fadeIn);
      }
      if(!isDefined(level.ambientRooms[level.activeAmbientRoom].reverb)) {
        deactivateReverb("snd_enveffectsprio_level", 2);
      } else {
        setReverb("snd_enveffectsprio_level", level.ambientRooms[level.activeAmbientRoom].reverb.reverbRoomType, level.ambientRooms[level.activeAmbientRoom].reverb.dry, level.ambientRooms[level.activeAmbientRoom].reverb.wet, level.ambientRooms[level.activeAmbientRoom].reverb.fade);
      }
    }
  }
}