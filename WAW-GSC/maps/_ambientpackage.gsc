/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_ambientpackage.gsc
**************************************/

#include maps\_utility;
#include maps\_equalizer;
#include common_scripts\utility;

init() {
  if(!level.clientscripts) {
    level.activeAmbientPackage = "";
    level.ambientPackages = [];
    thread updateActiveAmbientPackage();

    level.ambientPackageScriptOriginPool = [];
    for(i = 0; i < 5; i++) {
      level.ambientPackageScriptOriginPool[i] = spawnStruct();
      level.ambientPackageScriptOriginPool[i].org = spawn("script_origin", (0, 0, 0));
      level.ambientPackageScriptOriginPool[i].inuse = false;
      level.ambientPackageScriptOriginPool[i] thread scriptOriginPoolThread();
    }

    level.activeAmbientRoom = "";
    level.ambientRoomToneOriginPool = [];
    level.ambientRoomToneOriginPoolIndex = 0;
    for(i = 0; i < 5; i++) {
      level.ambientRoomToneOriginPool[i] = spawnStruct();
      level.ambientRoomToneOriginPool[i].org = spawn("script_origin", (0, 0, 0));
      level.ambientRoomToneOriginPool[i].inuse = false;
      level.ambientRoomToneOriginPool[i].alias = "";
    }
    level.ambientRooms = [];
    thread updateActiveAmbientRoom();
    thread delayed_first_notify();
  } else {
    maps\_utility::registerClientSys("ambientPackageCmd");
    maps\_utility::registerClientSys("ambientRoomCmd");
  }
}

wait_until_first_player() {
  players = get_players();
  if(!isDefined(players[0])) {
    level waittill("first_player_ready");
  }
}

delayed_first_notify() {
  wait_until_first_player();
  wait .1;
  level notify("updateActiveAmbientPackage");
  level notify("updateActiveAmbientRoom");
}

tidyup_triggers(client_num) {
  amb_triggers = getEntArray("ambient_package", "targetname");

  if(isDefined(amb_triggers) && amb_triggers.size > 0) {
    for(i = 0; i < amb_triggers.size; i++) {
      trig = amb_triggers[i];

      if(isDefined(trig.in_volume) && isDefined(trig.in_volume[client_num])) {
        trig.in_volume[client_num] = 0;
      }
    }
  }
}

monitor_for_player_leave_trigger(trigPlayer, useAmbientRoom, useAmbientPackage) {
  trigPlayer endon("disconnect");
  while(trigPlayer isTouching(self)) {
    wait 0.1;
  }

  self.in_volume[trigPlayer getentitynumber()] = 0;

  if(useAmbientPackage)
    deactivateAmbientPackage(self.script_ambientpackage, self.script_ambientpriority, trigPlayer);
  if(useAmbientRoom)
    deactivateAmbientRoom(self.script_ambientroom, self.script_ambientpriority, trigPlayer);
}

player_entered_trigger(trigPlayer, useAmbientRoom, useAmbientPackage) {
  index = trigPlayer getentitynumber();

  if(!isDefined(self.in_volume[index])) {
    self.in_volume[index] = 0;
  }

  if(self.in_volume[index] == 0) {
    if(useAmbientPackage)
      activateAmbientPackage(self.script_ambientpackage, self.script_ambientpriority, trigPlayer);
    if(useAmbientRoom)
      activateAmbientRoom(self.script_ambientroom, self.script_ambientpriority, trigPlayer);

    self.in_volume[index] = 1;

    self thread monitor_for_player_leave_trigger(trigPlayer, useAmbientRoom, useAmbientPackage);
  }
}

ambientPackageTrigger() {
  wait_until_first_player();

  if(!level.clientscripts) {
    hasAmbientRoom = isDefined(self.script_ambientroom);
    useAmbientRoom = hasAmbientRoom && isDefined(level.ambientRooms[self.script_ambientroom]);

    hasAmbientPackage = isDefined(self.script_ambientpackage);
    useAmbientPackage = hasAmbientPackage && isDefined(level.ambientPackages[self.script_ambientpackage]);

    if(hasAmbientRoom && !useAmbientRoom) {
      assertmsg("Trigger at " + self.origin + " references ambient room '" + self.script_ambientroom + "', but no such room has been declared\n");
      return;
    }

    if(hasAmbientPackage && !useAmbientPackage) {
      assertmsg("Trigger at " + self.origin + " references ambient package '" + self.script_ambientpackage + "', but no such package has been declared\n");
      return;
    }

    if(!useAmbientPackage && !useAmbientRoom) {
      assertmsg("Trigger at " + self.origin + " is an ambient trigger but has no room or package \n");
      return;
    }
  } else {
    useAmbientRoom = isDefined(self.script_ambientroom);

    useAmbientPackage = isDefined(self.script_ambientpackage);
  }

  if(!isDefined(self.script_ambientpriority)) {
    self.script_ambientpriority = 1;
  }

  self.in_volume = [];

  for(;;) {
    self waittill("trigger", trigPlayer);

    self player_entered_trigger(trigPlayer, useAmbientRoom, useAmbientPackage);

    wait(0.01);
  }
}

findHighestPriorityAmbientPackage() {
  package = "";
  priority = -1;

  packageArray = getArrayKeys(level.ambientPackages);
  for(i = 0; i < packageArray.size; i++) {
    for(j = 0; j < level.ambientPackages[packageArray[i]].priority.size; j++) {
      if(level.ambientPackages[packageArray[i]].refcount[j] && level.ambientPackages[packageArray[i]].priority[j] > priority) {
        package = packageArray[i];
        priority = level.ambientPackages[packageArray[i]].priority[j];
      }
    }
  }

  return package;
}

updateActiveAmbientPackage() {
  wait_until_first_player();

  for(;;) {
    level waittill("updateActiveAmbientPackage");
    newAmbientPackage = findHighestPriorityAmbientPackage();
    if(newAmbientPackage != "" && level.activeAmbientPackage != newAmbientPackage) {
      level notify("killambientElementThread" + level.activeAmbientPackage);
      level.activeAmbientPackage = newAmbientPackage;
      array_thread(level.ambientPackages[level.activeAmbientPackage].elements, ::ambientElementThread);
    }
  }
}

activateAmbientPackage(package, priority, trigPlayer) {
  if(!level.clientscripts) {
    if(!isDefined(level.ambientPackages[package])) {
      assertmsg("activateAmbientPackage: must declare ambient package \"" + package + "\" in level_amb main before it can be activated");
      return;
    }

    for(i = 0; i < level.ambientPackages[package].priority.size; i++) {
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
  } else {
    notifyString = "A " + package + " " + priority;
    maps\_utility::setClientSysState("ambientPackageCmd", notifyString, trigPlayer);
  }
}

deactivateAmbientPackage(package, priority, trigPlayer) {
  if(!level.clientscripts) {
    if(!isDefined(level.ambientPackages[package])) {
      assertmsg("deactivateAmbientPackage: must declare ambient package \"" + package + "\" in level_amb main before it can be deactivated");
      return;
    }

    for(i = 0; i < level.ambientPackages[package].priority.size; i++) {
      if(level.ambientPackages[package].priority[i] == priority && level.ambientPackages[package].refcount[i]) {
        level.ambientPackages[package].refcount[i]--;

        level notify("updateActiveAmbientPackage");
        return;
      }
    }
  } else {
    notifyString = "D " + package + " " + priority;
    maps\_utility::setClientSysState("ambientPackageCmd", notifyString, trigPlayer);
  }
}

declareAmbientPackage(package) {
  if(!level.clientscripts) {
    if(isDefined(level.ambientPackages[package])) {
      return;
    }
    level.ambientPackages[package] = spawnStruct();
    level.ambientPackages[package].priority = [];
    level.ambientPackages[package].refcount = [];
    level.ambientPackages[package].elements = [];
  }
}

addAmbientElement(package, alias, spawnMin, spawnMax, distMin, distMax, angleMin, angleMax) {
  if(!level.clientscripts) {
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
}

ambientElementThread() {
  level endon("killambientElementThread" + level.activeAmbientPackage);

  players = get_players();

  player = players[0];

  player endon("disconnect");

  timer = 0;

  if(self.distMin < 0) {
    for(;;) {
      timer = randomfloatrange(self.spawnMin, self.spawnMax);
      wait timer;

      player playLocalSound(self.alias);
    }
  } else {
    dist = 0;
    angle = 0;
    offset = (0, 0, 0);
    index = -1;
    for(;;) {
      timer = randomfloatrange(self.spawnMin, self.spawnMax);
      wait timer;

      index = getScriptOriginPoolIndex();
      if(index >= 0) {
        dist = randomintrange(self.distMin, self.distMax);
        angle = randomintrange(self.angleMin, self.angleMax);
        player_angle = player.angles[1];
        offset = anglesToForward((0, angle + player_angle, 0));
        offset = vectorscale(offset, dist);
        level.ambientPackageScriptOriginPool[index].org.origin = player getEye() + offset;

        wait .05;

        level.ambientPackageScriptOriginPool[index].org playSound(self.alias, "sounddone");
        level.ambientPackageScriptOriginPool[index] waittill("sounddone");
      }
    }
  }
}

getScriptOriginPoolIndex() {
  for(index = 0; index < level.ambientPackageScriptOriginPool.size; index++) {
    if(!level.ambientPackageScriptOriginPool[index].inuse) {
      level.ambientPackageScriptOriginPool[index].inuse = true;
      return index;
    }
  }

  return -1;
}

scriptOriginPoolThread() {
  for(;;) {
    self.org waittill("sounddone");
    self.inuse = false;
    self notify("sounddone");
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
  for(i = 0; i < roomArray.size; i++) {
    for(j = 0; j < level.ambientRooms[roomArray[i]].priority.size; j++) {
      if(level.ambientRooms[roomArray[i]].refcount[j]) {}

      if(level.ambientRooms[roomArray[i]].refcount[j] && level.ambientRooms[roomArray[i]].priority[j] > priority) {
        room = roomArray[i];
        priority = level.ambientRooms[roomArray[i]].priority[j];
      }
    }
  }

  return room;
}

updateActiveAmbientRoom() {
  org = level.ambientRoomToneOriginPool[0].org;

  wait_until_first_player();

  players = get_players();

  player = players[0];

  for(;;) {
    level waittill("updateActiveAmbientRoom");
    newAmbientRoom = findHighestPriorityAmbientRoom();
    if(newAmbientRoom != "" && level.activeAmbientRoom != newAmbientRoom) {
      if(level.activeAmbientRoom != "" && isDefined(level.ambientRooms[level.activeAmbientRoom].tone)) {
        for(i = 0; i < level.ambientRoomToneOriginPool.size; i++) {
          if(level.ambientRoomToneOriginPool[i].inuse && level.ambientRoomToneOriginPool[i].alias == level.ambientRooms[level.activeAmbientRoom].tone) {
            level.ambientRoomToneOriginPool[i].org stopLoopSound(level.ambientRooms[level.activeAmbientRoom].fadeOut);
            level.ambientRoomToneOriginPool[i] thread roomToneFadeOutTimerThread(level.ambientRooms[level.activeAmbientRoom].fadeOut);
            break;
          }
        }
      }

      level.activeAmbientRoom = newAmbientRoom;

      if(isDefined(level.ambientRooms[level.activeAmbientRoom].tone)) {
        for(i = 0; i < level.ambientRoomToneOriginPool.size; i++) {
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

        org playLoopSound(level.ambientRooms[level.activeAmbientRoom].tone, level.ambientRooms[level.activeAmbientRoom].fadeIn);
      }

      if(!isDefined(level.ambientRooms[level.activeAmbientRoom].reverb)) {
        player deactivateReverb("snd_enveffectsprio_level", 2);
      } else {
        player setReverb("snd_enveffectsprio_level", level.ambientRooms[level.activeAmbientRoom].reverb.reverbRoomType, level.ambientRooms[level.activeAmbientRoom].reverb.dry, level.ambientRooms[level.activeAmbientRoom].reverb.wet, level.ambientRooms[level.activeAmbientRoom].reverb.fade);
      }
    }
  }
}

activateAmbientRoom(room, priority, trigPlayer) {
  if(!level.clientscripts) {
    if(!isDefined(level.ambientRooms[room])) {
      assertmsg("activateAmbientRoom: must declare ambient room \"" + room + "\" in level_amb main before it can be activated");
      return;
    }

    for(i = 0; i < level.ambientRooms[room].priority.size; i++) {
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
  } else {
    notifyString = "A " + room + " " + priority;
    println("*** CS AR : " + room);
    maps\_utility::setClientSysState("ambientRoomCmd", notifyString, trigPlayer);
  }
}

deactivateAmbientRoom(room, priority, trigPlayer) {
  if(!level.clientscripts) {
    if(!isDefined(level.ambientRooms[room])) {
      assertmsg("deactivateAmbientRoom: must declare ambient room \"" + room + "\" in level_amb main before it can be deactivated");
      return;
    }

    for(i = 0; i < level.ambientRooms[room].priority.size; i++) {
      if(level.ambientRooms[room].priority[i] == priority && level.ambientRooms[room].refcount[i]) {
        level.ambientRooms[room].refcount[i]--;

        level notify("updateActiveAmbientRoom");
        return;
      }
    }
  } else {
    notifyString = "D " + room + " " + priority;
    maps\_utility::setClientSysState("ambientRoomCmd", notifyString, trigPlayer);
  }
}

declareAmbientRoom(room) {
  if(!level.clientscripts) {
    if(isDefined(level.ambientRooms[room])) {
      return;
    }
    level.ambientRooms[room] = spawnStruct();
    level.ambientRooms[room].priority = [];
    level.ambientRooms[room].refcount = [];
  }
}

setAmbientRoomTone(room, alias, fadeIn, fadeOut) {
  if(!level.clientscripts) {
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
}
setAmbientRoomReverb(room, reverbRoomType, dry, wet, fade) {
  if(!level.clientscripts) {
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
}