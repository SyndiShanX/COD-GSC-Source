/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_ambientpackage.csc
*********************************************/

#include clientscripts\_utility;

deactivateambientpackage(client, package, priority) {
  if(!isDefined(level.ambientpackages[package])) {
    assertmsg("deactivateAmbientPackage: must declare ambient package \"" + package + "\" in level_amb main before it can be deactivated");

    return;
  }

  for(i = 0; i < level.ambientpackages[package].priority.size; i++) {
    if(level.ambientpackages[package].priority[i] == priority && level.ambientpackages[package].refcount[i]) {
      level.ambientpackages[package].refcount[i]--;
      level notify("updateActiveAmbientPackage");
      return;
    }
  }
}

deactivateambientroom(client, room, priority) {
  if(level.usecodetriggers == 0) {
    if(!isDefined(level.ambientrooms[room])) {
      assertmsg("deactivateAmbientRoom: must declare ambient room \"" + room + "\" in level_amb main before it can be deactivated");

      return;
    }

    for(i = 0; i < level.ambientrooms[room].priority.size; i++) {
      if(level.ambientrooms[room].priority[i] == priority && level.ambientrooms[room].refcount[i]) {
        level.ambientrooms[room].refcount[i]--;
        level notify("updateActiveAmbientRoom");
        return;
      }
    }
  } else
    forceambientroom(0, 0);
}

ambientpackagetrigger() {
  hasambientroom = isDefined(self.script_ambientroom);
  useambientroom = hasambientroom && isDefined(level.ambientrooms[self.script_ambientroom]);
  hasambientpackage = isDefined(self.script_ambientpackage);
  useambientpackage = hasambientpackage && isDefined(level.ambientpackages[self.script_ambientpackage]);
  self.useambientroom = useambientroom;
  self.useambientpackage = useambientpackage;

  if(hasambientroom && !useambientroom) {
    iprintlnbold("Trigger at " + self.origin + " references ambient room '" + self.script_ambientroom + "', but no such room has been declared");

    return;
  }

  if(hasambientpackage && !useambientpackage) {
    iprintlnbold("Trigger at " + self.origin + " references ambient package '" + self.script_ambientpackage + "', but no such package has been declared");

    return;
  }

  if(!useambientpackage && !useambientroom) {
    iprintlnbold("Trigger at " + self.origin + " is an ambient trigger but has no room or package");

    return;
  }

  if(!isDefined(self.script_ambientpriority))
    self.script_ambientpriority = 1;
}

init_ambient_package_triggers() {
  wait 1.0;
  init_trigger_data();
  player = level.localplayers[0];
  remove_triggers_from_ent(player);
  trigs = getentarray(0, "ambient_package", "targetname");
  array_thread(trigs, ::ambientpackagetrigger);

  println("Client : " + trigs.size + " ambient package triggers.");
}

init() {
  level.usecodetriggers = 1;
  level.activeambientpackage = "";
  level.ambientpackages = [];
  level.ambientnummissedsounds = 0;
  level.ambientnumseqmissedsounds = 0;
  thread updateactiveambientpackage();
  thread saverestore();
  level.ambientpackagescriptoriginpool = [];

  for(i = 0; i < 5; i++) {
    level.ambientpackagescriptoriginpool[i] = spawnstruct();
    level.ambientpackagescriptoriginpool[i].org = spawnfakeent(0);
    level.ambientpackagescriptoriginpool[i].inuse = 0;
    level.ambientpackagescriptoriginpool[i] thread scriptoriginpoolthread();
  }

  level.activeambientroomname = "";
  level.activeambientroom = undefined;
  level.ambientrooms = [];
  level thread updateactiveambientroom();
  clientscripts\_utility::registersystem("ambientPackageCmd", ::ambientpackagecmdhandler);
  clientscripts\_utility::registersystem("ambientRoomCmd", ::ambientroomcmdhandler);
  level thread init_ambient_package_triggers();
}

declareambientpackage(package, defaultpackage) {
  if(isDefined(level.ambientpackages[package])) {
    return;
  }
  level.ambientpackages[package] = spawnstruct();
  level.ambientpackages[package].priority = [];
  level.ambientpackages[package].refcount = [];
  level.ambientpackages[package].elements = [];

  if(isDefined(defaultpackage))
    level.ambientpackages[package].defaultpackage = defaultpackage;
  else
    level.ambientpackages[package].defaultpackage = 0;

  init_trigger_data();
}

addambientelement(package, alias, spawnmin, spawnmax, distmin, distmax, anglemin, anglemax) {
  if(!isDefined(level.ambientpackages[package])) {
    assertmsg("addAmbientElement: must declare ambient package \"" + package + "\" in level_amb main before it can have elements added to it");

    return;
  }

  index = level.ambientpackages[package].elements.size;
  level.ambientpackages[package].elements[index] = spawnstruct();
  level.ambientpackages[package].elements[index].alias = alias;

  if(spawnmin < 0)
    spawnmin = 0;

  if(spawnmin >= spawnmax)
    spawnmax = spawnmin + 1;

  level.ambientpackages[package].elements[index].spawnmin = spawnmin;
  level.ambientpackages[package].elements[index].spawnmax = spawnmax;
  level.ambientpackages[package].elements[index].distmin = -1;
  level.ambientpackages[package].elements[index].distmax = -1;

  if(isDefined(distmin) && isDefined(distmax) && distmin >= 0 && distmin < distmax) {
    level.ambientpackages[package].elements[index].distmin = distmin;
    level.ambientpackages[package].elements[index].distmax = distmax;
  }

  level.ambientpackages[package].elements[index].anglemin = 0;
  level.ambientpackages[package].elements[index].anglemax = 359;

  if(isDefined(anglemin) && isDefined(anglemax) && anglemin >= 0 && anglemin < anglemax && anglemax <= 720) {
    level.ambientpackages[package].elements[index].anglemin = anglemin;
    level.ambientpackages[package].elements[index].anglemax = anglemax;
  }
}

declareambientroom(room, defaultroom) {
  if(isDefined(level.ambientrooms[room])) {
    return;
  }
  level.ambientrooms[room] = spawnstruct();
  level.ambientrooms[room].priority = [];
  level.ambientrooms[room].refcount = [];
  level.ambientrooms[room].ent = spawnfakeent(0);

  if(isDefined(defaultroom))
    level.ambientrooms[room].defaultroom = defaultroom;
  else
    level.ambientrooms[room].defaultroom = 0;

  init_trigger_data();
}

gettriggers(name) {
  trigs = getentarray(0, "ambient_package", "targetname");
  trigkeys = getarraykeys(trigs);
  triggerentnums = [];
  num = 0;

  for(i = 0; i < trigkeys.size; i++) {
    trigger = trigs[i];

    if(trigger.script_ambientroom == name) {
      triggernum = trigger getentitynumber();
      triggerentnums[num] = triggernum;
      num++;
    }
  }

  return triggerentnums;
}

gettriggerpriorities(name) {
  trigs = getentarray(0, "ambient_package", "targetname");
  trigkeys = getarraykeys(trigs);
  triggerpriorities = [];
  num = 0;

  for(i = 0; i < trigkeys.size; i++) {
    trigger = trigs[i];

    if(trigger.script_ambientroom == name) {
      triggerpriority = trigger.script_ambientpriority;
      triggerpriorities[num] = triggerpriority;
      num++;
    }
  }

  return triggerpriorities;
}

setambientroomtone(room, alias, fadein, fadeout) {
  if(!isDefined(level.ambientrooms[room])) {
    assertmsg("setAmbientRoomTone: must declare ambient room \"" + room + "\" in level_amb main before it can have a room tone set");

    return;
  }

  level.ambientrooms[room].tone = alias;
  level.ambientrooms[room].fadein = 2;

  if(isDefined(fadein) && fadein >= 0)
    level.ambientrooms[room].fadein = fadein;

  level.ambientrooms[room].fadeout = 2;

  if(isDefined(fadeout) && fadeout >= 0)
    level.ambientrooms[room].fadeout = fadeout;
}

setambientroomsnapshot(room, snapshot) {
  if(!isDefined(level.ambientrooms[room])) {
    assertmsg("setAmbientRoomSnapshot: must declare ambient room \"" + room + "\" in level_amb main before it can have a room snapshot set");

    return;
  }

  level.ambientrooms[room].snapshot = snapshot;
}

setambientroomsidechainduck(room, sidechainduck) {
  if(!isDefined(level.ambientrooms[room])) {
    assertmsg("setAmbientRoomSnapshot: must declare ambient room \"" + room + "\" in level_amb main before it can have a room side chain duck set");

    return;
  }

  level.ambientrooms[room].sidechainduck = sidechainduck;
}

setambientroomcontext(room, type, value) {
  if(!isDefined(level.ambientrooms[room])) {
    assertmsg("setAmbientRoomContext: must declare ambient room \"" + room + "\" in level_amb main before it can have a room context set");

    return;
  }

  if(!isDefined(level.ambientrooms[room].context))
    level.ambientrooms[room].context = [];

  level.ambientrooms[room].context[type] = value;

  if(!isDefined(level.ambientcontexts))
    level.ambientcontexts = [];

  level.ambientcontexts[type] = type;
}

setambientroomreverb(room, reverbroomtype, dry, wet, fade) {
  if(!isDefined(level.ambientrooms[room])) {
    assertmsg("setAmbientRoomReverb: must declare ambient room \"" + room + "\" in level_amb main before it can have a room reverb set");

    return;
  }

  level.ambientrooms[room].reverb = spawnstruct();
  level.ambientrooms[room].reverb.reverbroomtype = reverbroomtype;
  level.ambientrooms[room].reverb.dry = dry;
  level.ambientrooms[room].reverb.wet = wet;
  level.ambientrooms[room].reverb.fade = 2;

  if(isDefined(fade) && fade >= 0)
    level.ambientrooms[room].reverb.fade = fade;
}

activateambientpackage(clientnum, package, priority) {
  if(!isDefined(level.ambientpackages[package])) {
    assertmsg("activateAmbientPackage: must declare ambient package \"" + package + "\" in level_amb.csc main before it can be activated");

    return;
  }

  for(i = 0; i < level.ambientpackages[package].priority.size; i++) {
    if(level.ambientpackages[package].priority[i] == priority) {
      level.ambientpackages[package].refcount[i]++;
      break;
    }
  }

  if(i == level.ambientpackages[package].priority.size) {
    level.ambientpackages[package].priority[i] = priority;
    level.ambientpackages[package].refcount[i] = 1;
  }

  level notify("updateActiveAmbientPackage");
}

activateambientroom(clientnum, room, priority) {
  if(level.usecodetriggers == 0) {
    if(!isDefined(level.ambientrooms[room])) {
      assertmsg("activateAmbientRoom: must declare ambient room \"" + room + "\" in level_amb.csc main before it can be activated");

      return;
    }

    for(i = 0; i < level.ambientrooms[room].priority.size; i++) {
      if(level.ambientrooms[room].priority[i] == priority) {
        level.ambientrooms[room].refcount[i]++;
        break;
      }
    }

    if(i == level.ambientrooms[room].priority.size) {
      level.ambientrooms[room].priority[i] = priority;
      level.ambientrooms[room].refcount[i] = 1;
    }

    level notify("updateActiveAmbientRoom");
  } else {
    defaultroom = finddefaultroom();
    roomkeys = getarraykeys(level.ambientrooms);

    for(i = 0; i < roomkeys.size; i++) {
      ambientroom = level.ambientrooms[roomkeys[i]];

      if(!isDefined(ambientroom)) {
        continue;
      }
      if(roomkeys[i] == room) {
        if(isDefined(defaultroom) && defaultroom == room) {
          forceambientroom(1, 1, room);
          return;
        }

        forceambientroom(1, 0, room);
        return;
      }
    }

    if(isDefined(defaultroom)) {
      if(defaultroom == room)
        forceambientroom(1, 1, room);
    }
  }
}

ambientpackagecmdhandler(clientnum, state, oldstate) {
  if(state != "") {
    split_state = splitargs(state);

    if(split_state.size != 3) {
      println("*** Client : Malformed arguements to ambient packages " + state);

    } else {
      command = split_state[0];
      package = split_state[1];
      priority = int(split_state[2]);

      println("### APC : " + command + " " + package + " " + priority);

      if(command == "A") {
        if(!isDefined(level.ambientpackages[package])) {
          assertmsg("activateAmbientPackage: must declare ambient package \"" + package + "\" in level_amb.csc main before it can be activated");

          return;
        }

        for(i = 0; i < level.ambientpackages[package].priority.size; i++) {
          if(level.ambientpackages[package].priority[i] == priority) {
            level.ambientpackages[package].refcount[i]++;
            break;
          }
        }

        if(i == level.ambientpackages[package].priority.size) {
          level.ambientpackages[package].priority[i] = priority;
          level.ambientpackages[package].refcount[i] = 1;
        }

        level notify("updateActiveAmbientPackage");
      } else if(command == "D") {
        if(!isDefined(level.ambientpackages[package])) {
          assertmsg("deactivateAmbientPackage: must declare ambient package \"" + package + "\" in level_amb.csc main before it can be deactivated");

          return;
        }

        for(i = 0; i < level.ambientpackages[package].priority.size; i++) {
          if(level.ambientpackages[package].priority[i] == priority && level.ambientpackages[package].refcount[i]) {
            level.ambientpackages[package].refcount[i]--;

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

ambientroomcmdhandler(clientnum, state, oldstate) {
  if(state != "") {
    split_state = splitargs(state);

    if(split_state.size != 3) {
      println("*** Client : Malformed arguements to ambient packages " + state);

    } else {
      command = split_state[0];
      room = split_state[1];
      priority = int(split_state[2]);

      if(command == "A") {
        if(!isDefined(level.ambientrooms[room])) {
          assertmsg("activateAmbientRoom: must declare ambient room \"" + room + "\" in level_amb.csc main before it can be activated");

          return;
        }

        for(i = 0; i < level.ambientrooms[room].priority.size; i++) {
          if(level.ambientrooms[room].priority[i] == priority) {
            level.ambientrooms[room].refcount[i]++;
            break;
          }
        }

        if(i == level.ambientrooms[room].priority.size) {
          level.ambientrooms[room].priority[i] = priority;
          level.ambientrooms[room].refcount[i] = 1;
        }

        level notify("updateActiveAmbientRoom");
      } else if(command == "D") {
        if(!isDefined(level.ambientrooms[room])) {
          assertmsg("deactivateAmbientRoom: must declare ambient room \"" + room + "\" in level_amb.csc main before it can be deactivated");

          return;
        }

        for(i = 0; i < level.ambientrooms[room].priority.size; i++) {
          if(level.ambientrooms[room].priority[i] == priority && level.ambientrooms[room].refcount[i]) {
            level.ambientrooms[room].refcount[i]--;

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

ambientelementthread() {
  level endon("killambientElementThread" + level.activeambientpackage);
  timer = 0;

  if(self.distmin < 0) {
    for(;;) {
      timer = randomfloatrange(self.spawnmin, self.spawnmax);
      wait(timer);

      if(getdvarint(#"_id_0AEB127D") > 0)
        iprintlnbold("AP : playing2d: " + self.alias);

      playsound(0, self.alias);
    }
  } else {
    dist = 0;
    angle = 0;
    offset = (0, 0, 0);
    index = -1;

    for(;;) {
      timer = randomfloatrange(self.spawnmin, self.spawnmax);
      wait(timer);
      index = getscriptoriginpoolindex();

      if(index >= 0) {
        dist = randomintrange(self.distmin, self.distmax);
        angle = randomintrange(self.anglemin, self.anglemax);
        player_angle = getlocalclientangles(0)[1];
        offset = anglestoforward((0, angle + player_angle, 0));
        offset = vectorscale(offset, dist);
        pos = getlocalclienteyepos(0) + offset;
        setfakeentorg(0, level.ambientpackagescriptoriginpool[index].org, pos);
        level.ambientpackagescriptoriginpool[index].soundid = playsound(0, self.alias, pos);

        if(getdvarint(#"_id_0AEB127D") > 0) {
          if(level.ambientpackagescriptoriginpool[index].soundid == -1)
            col = vectorscale((1, 0, 0), 0.8);
          else
            col = vectorscale((0, 1, 0), 0.8);

          print3d(pos, "AP : " + self.alias, col, 1, 3, 30);
        }

        while(level.ambientpackagescriptoriginpool[index].soundid != -1)
          wait 0.01;
      }
    }
  }
}

getscriptoriginpoolindex() {
  for(index = 0; index < level.ambientpackagescriptoriginpool.size; index++) {
    if(!level.ambientpackagescriptoriginpool[index].inuse) {
      level.ambientpackagescriptoriginpool[index].inuse = 1;
      level.ambientnumseqmissedsounds = 0;
      return index;
    }
  }

  level.ambientnummissedsounds++;
  level.ambientnumseqmissedsounds++;

  if(getdvarint(#"_id_0AEB127D") > 0)
    iprintlnbold("No free origins " + level.ambientnumseqmissedsounds + " ( " + level.ambientnummissedsounds + " )");

  return -1;
}

scriptoriginpoolthread() {
  for(;;) {
    if(self.inuse == 1) {
      if(isDefined(self.soundid)) {
        if(self.soundid != -1) {
          if(!soundplaying(self.soundid)) {
            self.inuse = 0;
            self.soundid = -1;
          }
        } else
          self.inuse = 0;
      }
    }

    wait 0.01;
  }
}

findhighestpriorityambientpackage() {
  package = "";
  priority = -1;
  packagearray = getarraykeys(level.ambientpackages);

  for(i = 0; i < packagearray.size; i++) {
    for(j = 0; j < level.ambientpackages[packagearray[i]].priority.size; j++) {
      if(level.ambientpackages[packagearray[i]].refcount[j] && level.ambientpackages[packagearray[i]].priority[j] > priority) {
        package = packagearray[i];
        priority = level.ambientpackages[packagearray[i]].priority[j];
      }
    }
  }

  return package;
}

updateactiveambientpackage() {
  if(level.usecodetriggers == 1) {
    return;
  }
  for(;;) {
    level waittill("updateActiveAmbientPackage");
    newambientpackage = findhighestpriorityambientpackage();

    println("*** nap " + newambientpackage + " " + level.activeambientpackage);

    if(newambientpackage != "" && level.activeambientpackage != newambientpackage) {
      level notify("killambientElementThread" + level.activeambientpackage);
      level.activeambientpackage = newambientpackage;
      array_thread(level.ambientpackages[level.activeambientpackage].elements, ::ambientelementthread);
    }
  }
}

roomtonefadeouttimerthread(fadeout) {
  self endon("killRoomToneFadeOutTimer");
  wait(fadeout);
  self.inuse = 0;
}

findhighestpriorityambientroom() {
  room = "";
  priority = -1;
  roomarray = getarraykeys(level.ambientrooms);

  if(isDefined(roomarray)) {
    for(i = 0; i < roomarray.size; i++) {
      for(j = 0; j < level.ambientrooms[roomarray[i]].priority.size; j++) {
        if(level.ambientrooms[roomarray[i]].refcount[j]) {
        }

        if(level.ambientrooms[roomarray[i]].refcount[j] && level.ambientrooms[roomarray[i]].priority[j] > priority) {
          room = roomarray[i];
          priority = level.ambientrooms[roomarray[i]].priority[j];
        }
      }
    }
  }

  return room;
}

saverestore() {
  for(;;) {
    level waittill("save_restore");
    level.activeambientroom = undefined;
    level notify("updateActiveAmbientRoom");
  }
}

updateactiveambientroom() {
  if(level.usecodetriggers == 1) {
    return;
  }
  for(;;) {
    newambientroom = findhighestpriorityambientroom();

    if(newambientroom == level.activeambientroomname)
      level waittill("updateActiveAmbientRoom");

    println("*** nar " + newambientroom + " " + level.activeambientroomname);

    if(newambientroom == level.activeambientroomname) {
      continue;
    }
    oldroom = level.ambientrooms[level.activeambientroomname];
    newroom = level.ambientrooms[newambientroom];

    if(isDefined(oldroom) && isDefined(newroom) && isDefined(oldroom.tone) && isDefined(newroom.tone) && oldroom.tone == newroom.tone) {
      tmp = newroom.ent;
      newroom.ent = oldroom.ent;
      oldroom.ent = tmp;
    } else {
      if(isDefined(newroom) && isDefined(newroom.tone))
        newroom.id = playloopsound(0, newroom.ent, newroom.tone, newroom.fadein);
      else {
      }

      if(isDefined(oldroom) && isDefined(oldroom.tone))
        stoploopsound(0, oldroom.ent, oldroom.fadeout);
      else {
      }
    }

    if(!isDefined(newroom) || !isDefined(newroom.reverb))
      deactivatereverb("snd_enveffectsprio_level", 2);
    else
      setreverb("snd_enveffectsprio_level", newroom.reverb.reverbroomtype, newroom.reverb.dry, newroom.reverb.wet, newroom.reverb.fade);

    snapshot = "default";

    if(isDefined(newroom) && isDefined(newroom.snapshot))
      snapshot = newroom.snapshot;

    setambientsnapshot(snapshot);
    sidechainduck = "default";

    if(isDefined(newroom) && isDefined(newroom.sidechainduck))
      sidechainduck = newroom.sidechainduck;

    setambientsidechainduck(sidechainduck);
    level.activeambientroomname = newambientroom;
  }
}

init_trigger_data() {
  if(isDefined(level.ambientrooms)) {
    defaultroom = undefined;
    roomname = "";
    roomkeys = getarraykeys(level.ambientrooms);

    for(i = 0; i < roomkeys.size; i++) {
      room = level.ambientrooms[roomkeys[i]];
      roomname = roomkeys[i];

      if(!isDefined(room)) {
        continue;
      }
      hasambientroom = isDefined(level.ambientrooms[roomname]);
      hasambientpackage = isDefined(level.ambientpackages[roomname]);
      triggerentnums = gettriggers(roomname);
      triggerpriorities = gettriggerpriorities(roomname);
      entnumkeys = getarraykeys(triggerentnums);
      prioritykeys = getarraykeys(triggerpriorities);

      if(entnumkeys.size >= 64 || prioritykeys.size >= 64) {
        println("Ambient room problem. Room " + roomname + " exceeded limit of 8 triggers. Create a new room and lower the number of triggers. Number of triggers in room = " + entnumkeys.size);

        continue;
      }

      setambientpackage(hasambientroom, hasambientpackage, 0, room.defaultroom, roomname, triggerentnums, triggerpriorities);

      if(isDefined(room.context)) {
        keys = getarraykeys(room.context);

        if(isDefined(keys)) {
          for(j = 0; j < keys.size; j++)
            setambientroomcontextengine(roomname, keys[j], room.context[keys[j]], 0);
        }
      }
    }
  }

  trigs = getentarray(0, "ambient_package", "targetname");
  trigkeys = getarraykeys(trigs);

  for(i = 0; i < trigkeys.size; i++) {
    trigger = trigs[i];
    trigger setambienttrigger();
  }
}

finddefaultroom() {
  roomarray = getarraykeys(level.ambientrooms);

  if(isDefined(roomarray)) {
    for(i = 0; i < roomarray.size; i++) {
      if(level.ambientrooms[roomarray[i]].defaultroom == 1)
        return roomarray[i];
    }
  }

  return undefined;
}

finddefaultpackage() {
  packagearray = getarraykeys(level.ambientpackages);

  if(isDefined(packagearray)) {
    for(i = 0; i < packagearray.size; i++) {
      if(level.ambientpackages[packagearray[i]].defaultpackage == 1)
        return packagearray[i];
    }
  }

  return undefined;
}

switchactiveambientroom(ambientroom, roomcollidercent) {
  if(isDefined(level.activeambientroom))
    oldroom = level.activeambientroom;

  if(isDefined(ambientroom) && ambientroom != "")
    newroom = level.ambientrooms[ambientroom];
  else {
    newroom = undefined;
    defaultroom = finddefaultroom();

    if(isDefined(defaultroom)) {
      newroom = level.ambientrooms[defaultroom];
      ambientroom = newroom;
    }
  }

  if(isDefined(newroom) && isDefined(oldroom)) {
    if(newroom == oldroom)
      return;
  }

  if(isDefined(oldroom) && isDefined(newroom) && isDefined(oldroom.tone) && isDefined(newroom.tone) && oldroom.tone == newroom.tone) {
    tmp = newroom.ent;
    newroom.ent = oldroom.ent;
    oldroom.ent = tmp;
  } else {
    if(isDefined(newroom) && isDefined(newroom.tone))
      newroom.id = playloopsound(0, newroom.ent, newroom.tone, newroom.fadein);
    else {
    }

    if(isDefined(oldroom) && isDefined(oldroom.tone))
      stoploopsound(0, oldroom.ent, oldroom.fadeout);
  }

  if(!isDefined(newroom) || !isDefined(newroom.reverb))
    deactivatereverb("snd_enveffectsprio_level", 2);
  else
    setreverb("snd_enveffectsprio_level", newroom.reverb.reverbroomtype, newroom.reverb.dry, newroom.reverb.wet, newroom.reverb.fade);

  snapshot = "default";

  if(isDefined(newroom) && isDefined(newroom.snapshot))
    snapshot = newroom.snapshot;

  setambientsnapshot(snapshot);
  sidechainduck = "default";

  if(isDefined(newroom) && isDefined(newroom.sidechainduck))
    sidechainduck = newroom.sidechainduck;

  setambientsidechainduck(sidechainduck);

  if(isDefined(newroom))
    level.activeambientroom = newroom;
}

switchactiveambientpackage(ambientpackage, packagecollidercent) {
  packagename = "";

  if(isDefined(ambientpackage) && ambientpackage != "") {
    newpackage = level.ambientpackages[ambientpackage];
    packagename = ambientpackage;
  } else {
    newpackage = undefined;
    defaultpackage = finddefaultpackage();

    if(isDefined(defaultpackage) && isDefined(defaultpackage)) {
      if(defaultpackage) {
        newpackage = level.ambientpackages[defaultpackage];
        packagename = defaultpackage;
      }
    }
  }

  if(isDefined(level.activeambientpackage) && level.activeambientpackage != "")
    level notify("killambientElementThread" + level.activeambientpackage);

  if(isDefined(newpackage)) {
    level.activeambientpackage = packagename;
    array_thread(newpackage.elements, ::ambientelementthread);
  }
}

setcurrentambientstate(ambientroom, ambientpackage, roomcollidercent, packagecollidercent, defaultroom) {
  if(level.usecodetriggers == 0) {
    return;
  }
  switchactiveambientroom(ambientroom, roomcollidercent);
  switchactiveambientpackage(ambientpackage, packagecollidercent);
}

setcurrentaiambientstate(triggers, actors, numtriggers) {
  if(level.usecodetriggers == 0) {
    return;
  }
  wait 0.25;

  for(i = 0; i < actors.size; i++) {
    ambientroom = triggers[i];
    actorent = actors[i];

    if(isDefined(ambientroom) && isDefined(ambientroom.script_ambientroom)) {
      newroom = level.ambientrooms[ambientroom.script_ambientroom];
      continue;
    }

    newroom = undefined;
    defaultroom = finddefaultroom();

    if(isDefined(defaultroom)) {
      newroom = level.ambientrooms[defaultroom];
      ambientroom = newroom;
    }
  }
}