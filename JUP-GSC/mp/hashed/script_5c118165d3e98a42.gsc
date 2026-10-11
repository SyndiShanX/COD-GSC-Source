/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5c118165d3e98a42.gsc
*************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\anim;
#namespace namespace_a570a67947f18a4d;

function initelevators(prioritytable) {
  level.elevators = [];
  level.elevatorsfuncs = [];
  level.elevatorstops = [];
  level.var_52b8e16bc0cd79d6 = 0;
  scriptmodelanims();
  elevatorstops = getentitylessscriptablearray("elevator_stop", "script_noteworthy");
  var_ab337e7f8a1fa44a = [];

  foreach(stop in elevatorstops) {
    posstring = stop.origin[0] + "," + stop.origin[1];

    if(!isDefined(var_ab337e7f8a1fa44a[posstring])) {
      var_ab337e7f8a1fa44a[posstring] = [];
    }

    var_ab337e7f8a1fa44a[posstring][var_ab337e7f8a1fa44a[posstring].size] = stop;
    stop.open = 0;
    [stop.indicator] = getentitylessscriptablearray(stop.target, "targetname");
    frontposition = getStruct(stop.indicator.target, "targetname");
    stop.frontposition = frontposition.origin;
    stop.doors = getentitylessscriptablearray(stop.indicator.target, "targetname");
    stop.var_90dabe3606074803 = getEnt(stop.target, "targetname");

    if(level.mapname == "mp_biobunker" && isDefined(stop.script_linkname) && isendstr(stop.script_linkname, "elevator_50")) {
      stop.frontposition = (-15049, 7096, 1660);
    }

    var_6073fe6ff110d6a8 = getEntArray(stop.indicator.target, "targetname");

    foreach(targetent in var_6073fe6ff110d6a8) {
      if(targetent.classname == "script_brushmodel") {
        stop.aiclip = targetent;
        continue;
      }

      if(targetent.classname == "info_volume") {
        stop.var_907e66d3bf42c5a = targetent;
      }
    }

    foreach(door in stop.doors) {
      door.open = 0;
      door.clip = getEnt(door.target, "targetname");
      door.clip.initialorigin = door.clip.origin;
      openstruct = getStruct(door.clip.target, "targetname");
      door.clip.openposition = openstruct.origin;

      if(isDefined(openstruct.target) && openstruct.target != "") {
        bulletclip = getEnt(openstruct.target, "targetname");
        door.bulletclip = bulletclip;
      }
    }

    stop.waypointposition = getStruct(stop.target, "targetname");
  }

  elevatorcars = getStructArray("elevator_car", "script_noteworthy");

  foreach(elevatorset in var_ab337e7f8a1fa44a) {
    elevator = spawnStruct();
    elevator.parts = [];
    elevator.floors = [];
    group = "elevator_group_free";
    elevator.group = group;
    groundfloorindex = 0;

    foreach(stop in elevatorset) {
      stop.elevator = elevator;
    }

    checkorigin = elevatorset[groundfloorindex].origin;
    mindist = undefined;
    targetcar = undefined;

    foreach(car in elevatorcars) {
      dist = distancesquared(car.origin, checkorigin);

      if(!isDefined(mindist) || mindist > dist) {
        mindist = dist;
        targetcar = car;
      }
    }

    car = spawn("script_model", targetcar.origin);
    car.angles = targetcar.angles;

    switch (level.mapname) {
      case #"hash_721bd15904e6ff51":
        car setModel("building_biolabs_elevator_set_int");
        break;
      case #"hash_5d52d1f62d321d14":
        car setModel("building_biobunker_elevator_car_frame_one_way");
        break;
      default:
        car setModel("building_biolabs_elevator_set_int");
        break;
    }

    car.animname = "elevator";
    car setanimtree();
    car.elevator = elevator;
    car.moverdoesnotkill = 1;
    elevator.car = car;
    var_3b8c6779206fb1de = array_sort_with_func(elevatorset, &heightcompare);

    for(i = 0; i < var_3b8c6779206fb1de.size; i++) {
      elevator.floors[i] = var_3b8c6779206fb1de[i];
      elevator.floors[i].floornum = i;

      if(i > 0) {
        elevator.floors[i].targetheight = elevator.floors[i].origin[2] - elevator.floors[i - 1].origin[2] + elevator.floors[i - 1].targetheight;
      } else {
        elevator.floors[i].targetheight = elevator.car.origin[2];
      }

      elevator.floors[i].elevator = elevator;
      elevator.floors[i].floor = i;
      floororigin = (elevator.car.origin[0], elevator.car.origin[1], elevator.floors[i].targetheight);
      worldfloor = function_135de56d99fc05b8(floororigin);
      elevator.floors[i].worldfloor = ter_op(isDefined(worldfloor), worldfloor, i);
      stopid = function_c10ff09314e3f687(elevatorset[i]);

      if(!isDefined(stopid)) {
        level.var_52b8e16bc0cd79d6++;
        stopid = "unAuthorized_stop_" + level.var_52b8e16bc0cd79d6;
      }

      elevator.floors[i].stopid = stopid;
      level.elevatorstops[stopid] = elevator.floors[i];
    }

    elevator.id = elevator.floors[0].stopid;
    elevator.currentfloor = 0;
    elevator.targetfloor = 0;

    if(!isDefined(level.elevators[group])) {
      level.elevators[group] = [];
    }

    level.elevators[group][level.elevators[group].size] = elevator;
  }

  level.var_dd26b041c74afbd0 = [];
  level.var_a6c231ab0b186cd7 = [];
  level.var_d4f835afc5b8309b = [];
  level thread function_963fc4c3b794e7f0();
  level thread function_9003bd09b085a887();
  level.var_b212a36bec6cf8da = 1;

  if(isDefined(prioritytable)) {
    function_67e7f45e112e77f2(prioritytable);
  }

  level thread function_cb2806ac4b115c70();
}

function heightcompare(target1, target2) {
  return target1.origin[2] < target2.origin[2];
}

function function_298651e30e37ad6a(node1, node2) {
  return distancesquared(node1.origin, self.origin) < distancesquared(node2.origin, self.origin);
}

function function_ba13d98dab57ca7e(group, state, func) {
  if(!isDefined(level.elevatorsfuncs[group])) {
    level.elevatorsfuncs[group] = [];
  }

  level.elevatorsfuncs[group][state] = func;
}

function callelevator(owner, group, state, callorigin, pickrule, floors, assignedcallback, var_fd5c5e2ffb3b1d08) {
  var_4087e8c204288c38 = spawnStruct();
  var_4087e8c204288c38.owner = owner;
  var_4087e8c204288c38.group = group;
  var_4087e8c204288c38.state = state;
  var_4087e8c204288c38.callorigin = callorigin;
  var_4087e8c204288c38.pickrule = pickrule;
  var_4087e8c204288c38.idealfloors = floors;
  var_4087e8c204288c38.assignedcallback = assignedcallback;
  var_4087e8c204288c38.var_fd5c5e2ffb3b1d08 = var_fd5c5e2ffb3b1d08;
  level.var_a6c231ab0b186cd7[level.var_a6c231ab0b186cd7.size] = var_4087e8c204288c38;
}

function function_20e0f2f56a5ba71f(owner, group, state, id, assignedcallback, var_fd5c5e2ffb3b1d08) {
  var_4087e8c204288c38 = spawnStruct();
  var_4087e8c204288c38.owner = owner;
  var_4087e8c204288c38.group = group;
  var_4087e8c204288c38.state = state;
  var_4087e8c204288c38.pickrule = "elevator_pick_rule_id";
  var_4087e8c204288c38.id = id;
  var_4087e8c204288c38.assignedcallback = assignedcallback;
  var_4087e8c204288c38.var_fd5c5e2ffb3b1d08 = var_fd5c5e2ffb3b1d08;
  level.var_a6c231ab0b186cd7[level.var_a6c231ab0b186cd7.size] = var_4087e8c204288c38;
}

function function_92beb6591366ab26(owner, group, state, callorigin, pickrule) {
  elevator = undefined;

  switch (pickrule) {
    case #"hash_a30cdbeb79218fc6":
      elevator = function_7bee30545564f6d2(callorigin);
      break;
  }

  if(isDefined(elevator)) {
    elevator startelevator(group, state);
  }

  return elevator;
}

function activatefloor(floornum) {
  if(!array_contains(level.var_d4f835afc5b8309b, floornum)) {
    level.var_d4f835afc5b8309b[level.var_d4f835afc5b8309b.size] = floornum;
  }
}

function function_e81853b8e49151ba(floornum) {
  if(!isDefined(floornum)) {
    return 0;
  }

  return array_contains(level.var_d4f835afc5b8309b, floornum);
}

function function_135de56d99fc05b8(origin) {
  if(isDefined(level.var_172e4b629498723c)) {
    return [[level.var_172e4b629498723c]](origin);
  }
}

function function_c10ff09314e3f687(var_d54026d89e48a921) {
  if(isDefined(var_d54026d89e48a921.script_linkname)) {
    groupstr = strtok(var_d54026d89e48a921.script_linkname, "_");

    if(isDefined(groupstr) && groupstr.size > 0) {
      stopid = groupstr[1];

      for(i = 2; i < groupstr.size; i++) {
        stopid = stopid + "_" + groupstr[i];
      }

      return stopid;
    }
  }

  return undefined;
}

function function_9003bd09b085a887() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");

  foreach(elevator in level.elevators["elevator_group_free"]) {
    elevatorextbutton = elevator.floors[elevator.currentfloor];
    elevatorextbutton.aiclip disconnectPaths();
  }
}

function function_963fc4c3b794e7f0() {
  level endon("game_ended");
  var_34901859711436c9 = 0;

  while(true) {
    for(i = 0; i < level.var_a6c231ab0b186cd7.size; i++) {
      if(level.elevators["elevator_group_free"].size > 0) {
        elevator = undefined;
        request = level.var_a6c231ab0b186cd7[i];

        switch (request.pickrule) {
          case #"hash_fba835080c4a6b66":
            elevator = function_7ea9434601358283();
            break;
          case #"hash_597ee058566f8b00":
            assert(isDefined(request.owner), "<dev string:x1c>" + "<dev string:x48>");
            elevator = function_2ddb2d81ee6055ce(request.owner);
            break;
          case #"hash_a510ae28921a5f2":
            assert(isDefined(request.owner) && isarray(request.idealfloors), "<dev string:x6f>" + "<dev string:xad>");
            elevator = function_2ddb2d81ee6055ce(request.owner, request.idealfloors);
            break;
          case #"hash_a30cdbeb79218fc6":
            assert(isDefined(request.callorigin), "<dev string:xe4>" + "<dev string:x100>");
            elevator = function_7bee30545564f6d2(request.callorigin);
            break;
          case #"hash_db4c90c3bb8c6cbc":
            assert(isDefined(request.id), "<dev string:x129>" + "<dev string:x142>");
            elevator = function_ac05b2a25b870e68(request.id);
            break;
        }

        if(isDefined(elevator)) {
          if(isDefined(request.assignedcallback)) {
            level thread[[request.assignedcallback]](elevator, request.var_fd5c5e2ffb3b1d08);
          }

          elevator startelevator(request.group, request.state);
          level.var_a6c231ab0b186cd7[i] = undefined;
          var_34901859711436c9 = 1;
        }
      }
    }

    if(istrue(var_34901859711436c9)) {
      level.var_a6c231ab0b186cd7 = array_removeundefined(level.var_a6c231ab0b186cd7);
      var_34901859711436c9 = 0;
    }

    waitframe();
  }
}

function function_67e7f45e112e77f2(table) {
  var_8f117d9581995c82 = 0;
  var_bbe34f2ccae3241c = 1;
  numrows = 0;

  if(tableexists(table)) {
    numrows = tablelookupgetnumrows(table);
  } else {
    assertmsg(table + "<dev string:x163>");
    return;
  }

  level.var_6fdfdc44a9268868 = [];

  for(i = 0; i < numrows; i++) {
    prioritynode = spawnStruct();
    csvorigin = tablelookupbyrow(table, i, var_8f117d9581995c82);
    tmporigin = strtok(csvorigin, ", ");
    checkorigin = (float(tmporigin[0]), float(tmporigin[1]), float(tmporigin[2]));
    prioritynode.origin = checkorigin;
    prioritynode.enable = 1;
    var_474cb0ec00d51c72 = tablelookupbyrow(table, i, var_bbe34f2ccae3241c);
    var_975cc022038f8367 = strtok(var_474cb0ec00d51c72, ", ");
    prioritynode.elevatorids = var_975cc022038f8367;
    level.var_6fdfdc44a9268868[i] = prioritynode;
  }
}

function function_7ea9434601358283() {
  elevator = array_random(level.elevators["elevator_group_free"]);

  if(isDefined(elevator)) {
    if(elevator.floors.size > 1) {
      elevator.targetfloor = array_random(elevator.floors);
    }

    return elevator;
  }

  return undefined;
}

function function_7bee30545564f6d2(callorigin) {
  if(!isDefined(level.var_6fdfdc44a9268868) || level.var_6fdfdc44a9268868.size == 0) {
    assertmsg("<dev string:x175>");
    return undefined;
  }

  originstruct = spawnStruct();
  originstruct.origin = callorigin;
  var_2621d6d616a10f79 = originstruct array_sort_with_func(level.var_6fdfdc44a9268868, &function_298651e30e37ad6a);
  var_57cda711a1d5019b = [];

  foreach(node in var_2621d6d616a10f79) {
    if(istrue(node.enable)) {
      var_57cda711a1d5019b = node.elevatorids;
      break;
    }
  }

  foreach(stopid in var_57cda711a1d5019b) {
    stop = level.elevatorstops[stopid];
    elevator = function_ac05b2a25b870e68(stopid);

    if(isDefined(elevator)) {
      reachable = 1;

      if(isDefined(level.var_6d879681512cd627)) {
        reachable = [[level.var_6d879681512cd627]](stop, callorigin);
      }

      if(reachable) {
        return elevator;
      }
    }
  }

  return undefined;
}

function function_ac05b2a25b870e68(stopid) {
  stop = level.elevatorstops[stopid];

  if(stop.elevator.group == "elevator_group_free") {
    stop.elevator.targetfloor = stop.floor;
    return stop.elevator;
  }

  return undefined;
}

function function_b7ee067fa2ed527d(stopid) {
  return level.elevatorstops[stopid].elevator;
}

function function_ea03313f519b9e06(group) {
  return level.elevators[group];
}

function function_e8f746dfa279cefd(stopid) {
  return level.elevatorstops[stopid];
}

function function_e273ac02f95d54e5(owner, worldfloors) {
  foreach(worldfloor in worldfloors) {
    foreach(stop in level.elevatorstops) {
      if(worldfloor == stop.worldfloor) {
        var_e3baffc8f1c9431b = stop.elevator;
        pickedinfo = level.var_dd26b041c74afbd0[owner][var_e3baffc8f1c9431b.id];

        if(!isDefined(pickedinfo) || array_contains(pickedinfo.availablefloors, stop.floor)) {
          return true;
        }
      }
    }
  }

  return false;
}

function function_2ddb2d81ee6055ce(owner, worldfloors) {
  assertex(isDefined(owner), "<dev string:x1d4>");

  if(!isDefined(level.var_dd26b041c74afbd0[owner])) {
    level.var_dd26b041c74afbd0[owner] = [];
  }

  var_133738871e398cf3 = [];

  if(!isDefined(worldfloors)) {
    var_133738871e398cf3 = level.var_d4f835afc5b8309b;
  } else if(isarray(worldfloors)) {
    foreach(worldfloor in worldfloors) {
      if(function_e81853b8e49151ba(worldfloor)) {
        var_133738871e398cf3[var_133738871e398cf3.size] = worldfloor;
      }
    }
  } else {
    assert("<dev string:x206>");
    return undefined;
  }

  if(var_133738871e398cf3.size == 0) {
    return undefined;
  }

  availableelevators = [];

  foreach(elevator in level.elevators["elevator_group_free"]) {
    availableelevator = undefined;
    pickedinfo = level.var_dd26b041c74afbd0[owner][elevator.id];

    if(!isDefined(pickedinfo)) {
      for(i = 0; i < elevator.floors.size; i++) {
        worldfloor = elevator.floors[i].worldfloor;

        if(array_contains(var_133738871e398cf3, worldfloor)) {
          if(!isDefined(availableelevator)) {
            availableelevator = spawnStruct();
            availableelevator.var_96d5ebb0b818388c = [];
            availableelevator.elevator = elevator;
            availableelevators[availableelevators.size] = availableelevator;
          }

          availableelevator.var_96d5ebb0b818388c[availableelevator.var_96d5ebb0b818388c.size] = i;
        }
      }

      continue;
    }

    if(pickedinfo.availablefloors.size > 0) {
      for(i = 0; i < pickedinfo.availablefloors.size; i++) {
        worldfloor = elevator.floors[pickedinfo.availablefloors[i]].worldfloor;

        if(array_contains(var_133738871e398cf3, worldfloor)) {
          if(!isDefined(availableelevator)) {
            availableelevator = spawnStruct();
            availableelevator.var_96d5ebb0b818388c = [];
            availableelevator.elevator = elevator;
            availableelevators[availableelevators.size] = availableelevator;
          }

          availableelevator.var_96d5ebb0b818388c[availableelevator.var_96d5ebb0b818388c.size] = pickedinfo.availablefloors[i];
        }
      }
    }
  }

  if(availableelevators.size == 0) {
    return undefined;
  }

  var_c814db13c0abc6ab = availableelevators[randomint(availableelevators.size)];
  elevator = var_c814db13c0abc6ab.elevator;
  var_96d5ebb0b818388c = var_c814db13c0abc6ab.var_96d5ebb0b818388c;
  pickedinfo = level.var_dd26b041c74afbd0[owner][elevator.id];

  if(!isDefined(pickedinfo)) {
    pickedinfo = spawnStruct();
    pickedinfo.availablefloors = [];

    for(i = 0; i < elevator.floors.size; i++) {
      pickedinfo.availablefloors[i] = i;
    }
  }

  elevator.targetfloor = array_random(var_96d5ebb0b818388c);
  pickedinfo.availablefloors = array_remove(pickedinfo.availablefloors, elevator.targetfloor);
  level.var_dd26b041c74afbd0[owner][elevator.id] = pickedinfo;
  return elevator;
}

function startelevator(group, state) {
  assert(group != "<dev string:x224>" && group != self.group, "<dev string:x23b>");
  level.elevators[self.group] = array_remove(level.elevators[self.group], self);
  self.group = group;
  self.state = state;

  if(!isDefined(level.elevators[group])) {
    level.elevators[group] = [];
  }

  level.elevators[group][level.elevators[group].size] = self;
  waitframe();
  thread function_580e82173ae3940c();
}

function releaseelevator() {
  level.elevators[self.group] = array_remove(level.elevators[self.group], self);
  self.group = "elevator_group_free";
  self.state = "";
  level.elevators["elevator_group_free"][level.elevators["elevator_group_free"].size] = self;
  self notify("elevator_release");
}

function function_580e82173ae3940c() {
  level endon("game_ended");
  self endon("elevator_release");

  while(true) {
    keepprint = 1;

    if(!isDefined(self.group)) {
      keepprint = 0;
      logstring(self.id + " Group is undefined for this elevator");
    }

    if(keepprint && !isDefined(level.elevatorsfuncs[self.group])) {
      keepprint = 0;
      logstring(self.id + " Group " + self.group + " has not registered FSM yet");
    }

    if(keepprint && !isDefined(self.state)) {
      keepprint = 0;
      logstring(self.id + " State is undefined for this elevator in Group: " + self.group);
    }

    if(keepprint && !isDefined(level.elevatorsfuncs[self.group][self.state])) {
      keepprint = 0;
      logstring(self.id + " State " + self.state + " has not been registered FSM to Group: " + self.group);
    }

    if(keepprint) {
      logstring("===============Elevator FSM Log===============");
      logstring("Elevator Id: " + self.id);
      logstring("Group: " + self.group);
      logstring("State: " + self.state);
      logstring("===============Elevator FSM Log End===============");
    }

    self[[level.elevatorsfuncs[self.group][self.state]]]();
  }
}

function elevatormove() {
  duration = self.targetfloor - self.currentfloor;
  duration = ter_op(duration >= 0, duration, self.currentfloor - self.targetfloor);

  if(duration != 0) {
    function_26adb9abdd954d53("reinforcement_closed");
    self.car moveTo((self.car.origin[0], self.car.origin[1], self.floors[self.targetfloor].targetheight), duration);
    wait duration;
    waitframe();
  }

  self.currentfloor = self.targetfloor;
}

function elevatordooropen() {
  foreach(door in self.doors) {
    door setscriptablepartstate("door", "open", 0);
  }

  wait 2;

  foreach(door in self.doors) {
    door.state = door getscriptablepartstate("door");
  }

  println("<dev string:x25e>" + self.elevator.id + "<dev string:x279>" + self.elevator.currentfloor + "<dev string:x28c>" + self.elevator.targetfloor + "<dev string:x29e>" + self.doors[0].state + "<dev string:x2aa>" + self.doors[1].state);
}

function elevatordoorclose() {
  foreach(door in self.doors) {
    door setscriptablepartstate("door", "closed", 0);
  }

  wait 2;

  foreach(door in self.doors) {
    door.state = door getscriptablepartstate("door");
  }

  println("<dev string:x2af>" + self.elevator.id + "<dev string:x279>" + self.elevator.currentfloor + "<dev string:x28c>" + self.elevator.targetfloor + "<dev string:x29e>" + self.doors[0].state + "<dev string:x2aa>" + self.doors[1].state);
}

function function_88c392696fd02dc4() {
  foreach(door in self.doors) {
    door setscriptablepartstate("door", "reinforcement_open", 0);
  }

  wait 2;

  foreach(door in self.doors) {
    door.state = door getscriptablepartstate("door");
  }

  println("<dev string:x2cb>" + self.elevator.id + "<dev string:x279>" + self.elevator.currentfloor + "<dev string:x28c>" + self.elevator.targetfloor + "<dev string:x29e>" + self.doors[0].state + "<dev string:x2aa>" + self.doors[1].state);
}

function function_d32c693d3a04f8f8() {
  foreach(door in self.doors) {
    door setscriptablepartstate("door", "reinforcement_closed", 0);
  }

  wait 2;

  foreach(door in self.doors) {
    door.state = door getscriptablepartstate("door");
  }

  println("<dev string:x2f0>" + self.elevator.id + "<dev string:x279>" + self.elevator.currentfloor + "<dev string:x28c>" + self.elevator.targetfloor + "<dev string:x29e>" + self.doors[0].state + "<dev string:x2aa>" + self.doors[1].state);
}

function function_26adb9abdd954d53(closestate) {
  foreach(floor in self.floors) {
    foreach(door in floor.doors) {
      door setscriptablepartstate("door", closestate, 0);
    }
  }
}

#using_animtree("script_model");

function scriptmodelanims() {
  level.scr_animtree["elevator"] = #animtree;
  level.scr_anim["elevator"]["close"] = % iw9_elevator_int_door_close;
  level.scr_eventanim["elevator"]["close"] = % "iw9_elevator_int_door_close";
  level.scr_animtree["elevator"] = #animtree;
  level.scr_anim["elevator"]["open"] = % iw9_elevator_int_door_open;
  level.scr_eventanim["elevator"]["open"] = % "iw9_elevator_int_door_open";
}

function function_cb2806ac4b115c70() {
  level waittill("<dev string:x316>");
  level thread function_af5ba99924c0d3d6(@ "hash_b4957f27fef0ad51");
  level thread function_84d0ae2111fcc4be(@ "hash_7f3c55bc1b0ba1dd");
}

function function_af5ba99924c0d3d6(dvarname) {
  level endon("<dev string:x328>");
  setdevdvarifuninitialized(dvarname, 0);
  var_2193ee1cb4487092 = ["<dev string:x224>", "<dev string:x336>", "<dev string:x356>", "<dev string:x37a>"];
  var_26af4f7e687bacaf = [];
  var_26af4f7e687bacaf["<dev string:x224>"] = (0, 1, 0);
  var_26af4f7e687bacaf["<dev string:x336>"] = (1, 0, 0);
  var_26af4f7e687bacaf["<dev string:x356>"] = (1, 1, 0);
  var_26af4f7e687bacaf["<dev string:x37a>"] = (0, 0, 1);
  var_58e7b7390381f53b = 64;

  while(true) {
    shoulddraw = getdvarint(dvarname);

    if(shoulddraw == 1) {
      foreach(group in var_2193ee1cb4487092) {
        if(isDefined(level.elevators[group])) {
          foreach(elevator in level.elevators[group]) {
            foreach(floor in elevator.floors) {
              sphere(floor.origin, var_58e7b7390381f53b, var_26af4f7e687bacaf[group]);
            }

            sphere(elevator.car.origin, 16, (1, 0, 1));
            debugstar(elevator.car.origin, (1, 0, 1), 1, elevator.id, 0.8);
          }
        }
      }
    }

    waitframe();
  }
}

function function_84d0ae2111fcc4be(dvarname) {
  level endon("<dev string:x328>");
  setdevdvarifuninitialized(dvarname, 0);
  var_58e7b7390381f53b = 32;
  var_a573ceab7ce7a507 = (1, 1, 1);

  while(true) {
    shoulddraw = getdvarint(dvarname);

    if(shoulddraw == 1) {
      foreach(list in level.var_6fdfdc44a9268868) {
        sphere(list.origin, var_58e7b7390381f53b, var_a573ceab7ce7a507);
      }
    }

    waitframe();
  }
}

# /