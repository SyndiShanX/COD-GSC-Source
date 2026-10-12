/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\elevators.gsc
***********************************************/

#using scripts\common\anim;
#using scripts\common\elevators;
#using scripts\common\utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\anim;
#namespace elevators;

function initelevators() {
  if(isDefined(level.var_b3c54f58528f476)) {
    return;
  }

  level.var_b3c54f58528f476 = 1;
  level waittill("prematch_done");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("button", &elevatorbuttonpressed);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("elevator_ext_button", &elevatorextbuttonpressed);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("elevator_int_button", &function_d99e32e6787622fe);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("elevator_int_button_double", &function_d99e32e6787622fe);
  level.elevatorsfuncs = [];
  level.elevatorsfuncs["waiting"] = &function_4497ec9c55f12123;
  level.elevatorsfuncs["doors_open"] = &function_ec009a967d1d5eb9;
  level.elevatorsfuncs["doors_closing"] = &function_8b680b3ef155fc34;
  level.elevatorsfuncs["moving"] = &fsm_elevatormove;
  level.elevators = [];
  level.elevatorstops = [];
  level.elevatoronspawnplayer = &elevatoronspawnplayer;
  script_model_anims("default");
  elevatorcars = scripts\engine\utility::getStructArray("elevator_car", "script_noteworthy");
  elevatorstops = getentitylessscriptablearray("elevator_stop", "script_noteworthy");
  waitframe();

  foreach(stop in elevatorstops) {
    initelevatorstop(stop);
    waitframe();
  }

  foreach(elevatorset in level.elevatorstops) {
    if(elevatorset.size != 2) {
      continue;
    }

    elevator = initelevatorset(elevatorset, elevatorcars);
    elevator thread function_12e75ac514f84d03();
  }
}

function initelevatorstop(stop) {
  stop.open = 0;
  [stop.indicator] = getentitylessscriptablearray(stop.target, "targetname");
  stop.doors = getentitylessscriptablearray(stop.indicator.target, "targetname");
  stop.entsblocking = [];
  s_anchor = undefined;

  if(isDefined(stop.doors[0].target)) {
    s_anchor = getStruct(stop.doors[0].target, "targetname");
  }

  assertex(stop.doors.size != 0 && stop.doors.size <= 2, "<dev string:x1c>");

  foreach(door in stop.doors) {
    door.open = 0;
  }

  if(stop.doors.size == 1) {
    stop.doormidpoint = stop.doors[0].origin;
  } else {
    stop.doormidpoint = averagepoint([stop.doors[0].origin, stop.doors[1].origin]);
  }

  if(isDefined(s_anchor)) {
    posstring = s_anchor.origin[0] + "," + s_anchor.origin[1];
  } else {
    posstring = stop.doormidpoint[0] + "," + stop.doormidpoint[1];
  }

  if(!isDefined(level.elevatorstops[posstring])) {
    level.elevatorstops[posstring] = [];
  }

  level.elevatorstops[posstring][level.elevatorstops[posstring].size] = stop;
  stop.playerblocked = 0;

  if(isDefined(stop.doors[0].target)) {
    if(isDefined(s_anchor)) {
      noenttrigger = getnoentvolumearray(s_anchor.target, "targetname");
    } else {
      noenttrigger = getnoentvolumearray(stop.doors[0].target, "targetname");
    }

    stop.trigger = noenttrigger[0];

    if(isDefined(stop.trigger)) {
      stop thread elevatortriggerfunc();
    }
  }

  return posstring;
}

function initelevatorset(elevatorset, elevatorcars, overridemodel) {
  elevator = spawnStruct();
  elevator.parts = [];
  elevator.floors = [];
  elevator.state = "doors_open";

  if(elevatorset.size > 1) {
    groundfloorindex = ter_op(elevatorset[0].origin[2] < elevatorset[1].origin[2], 0, 1);
  } else {
    groundfloorindex = 0;
  }

  foreach(stop in elevatorset) {
    stop.elevator = elevator;
  }

  checkorigin = elevatorset[groundfloorindex].origin;
  mindist = undefined;
  targetcar = undefined;
  var_d4a1fd41d06b194 = undefined;

  foreach(car in elevatorcars) {
    if(!isDefined(mindist)) {
      mindist = distancesquared(car.origin, checkorigin);
      targetcar = car;
      var_d4a1fd41d06b194 = car.targetname;
      continue;
    }

    dist = distancesquared(car.origin, checkorigin);

    if(dist < mindist) {
      mindist = dist;
      targetcar = car;
      var_d4a1fd41d06b194 = car.targetname;
    }
  }

  car = spawn("script_model", targetcar.origin);
  car.angles = targetcar.angles;
  car setModel(default_to(overridemodel, "building_saba_elevator_set_int"));
  car.animname = "elevator";
  car setanimtree();
  car setscriptablepartstate("lights", "on");
  car.elevator = elevator;
  car.occupants = [];
  car.var_27abfc12040d5908 = 0;
  createnavobstaclebybounds(car.origin, (90, 90, 90), car.angles);

  if(isDefined(targetcar.script_parameters)) {
    var_6b72ca36ef52aa27 = strtok(targetcar.script_parameters, ",");
    car.n_travel_time = float(var_6b72ca36ef52aa27[0]);

    if(var_6b72ca36ef52aa27.size >= 3) {
      car.n_accel_time = float(var_6b72ca36ef52aa27[1]);
      car.var_23e93511918b6091 = float(var_6b72ca36ef52aa27[2]);
    } else if(var_6b72ca36ef52aa27.size == 2) {
      car.n_accel_time = float(var_6b72ca36ef52aa27[1]);
      car.var_23e93511918b6091 = car.n_accel_time;
    } else if(car.n_travel_time >= 4) {
      car.n_accel_time = 2;
      car.var_23e93511918b6091 = 2;
    } else {
      car.n_accel_time = 0;
      car.var_23e93511918b6091 = 0;
    }
  } else {
    car.n_accel_time = 2;
    car.var_23e93511918b6091 = 2;
  }

  if(!isDefined(car.var_d4a1fd41d06b194)) {
    car.var_d4a1fd41d06b194 = "default";
  }

  switch (car.var_d4a1fd41d06b194) {
    case #"hash_dfb267e42bb20045":
      var_e13e96bcd56df32 = "t10_ava_building_elevator_double_set_int";
      car.animname = "elevator_double";
      car.var_ef04438af292c145 = 1;
      break;
    case #"hash_5971965ed985a26c":
      var_e13e96bcd56df32 = "t10_ava_machinery_elevator_sm_01_int_set";
      car.animname = "elevator_small";
      car.var_ef04438af292c145 = 0;
      break;
    case #"hash_6bf513acc2adb471":
      var_e13e96bcd56df32 = "t10_ava_machinery_elevator_dbl_01_int_set";
      car.animname = "elevator_small_double";
      car.var_ef04438af292c145 = 1;
      break;
    default:
      var_e13e96bcd56df32 = "building_saba_elevator_set_int";
      car.animname = "elevator";
      car.var_ef04438af292c145 = 0;
      break;
  }

  if(!isDefined(car.str_model_name)) {
    car.str_model_name = var_e13e96bcd56df32;
  }

  car setModel(car.str_model_name);
  car setanimtree();
  assertex(car isscriptable(), "<dev string:x48>");

  if(!car isscriptable()) {
    return;
  }

  if(isDefined(targetcar.target)) {
    corner_a = scripts\engine\utility::getStruct(targetcar.target, "targetname");

    if(isDefined(corner_a)) {
      corner_b = scripts\engine\utility::getStruct(corner_a.target, "targetname");

      if(isDefined(corner_b)) {
        corner_c = scripts\engine\utility::getStruct(corner_b.target, "targetname");

        if(isDefined(corner_c)) {
          corner_d = scripts\engine\utility::getStruct(corner_c.target, "targetname");

          if(isDefined(corner_d)) {
            car.carheight = 144;
            car.corner_a = corner_a.origin;
            car.corner_b = corner_b.origin;
            car.corner_c = corner_c.origin;
            car.corner_d = corner_d.origin;
            car.var_27abfc12040d5908 = 1;
          }
        }
      }
    }
  }

  if(!car.var_27abfc12040d5908 && car.model == "building_saba_elevator_set_int") {
    x_1 = -84;
    x_2 = 76;
    y_1 = -88;
    y_2 = 88;
    car.carheight = 144;
    car.corner_a = car.origin + rotatepointaroundvector((0, 0, 1), (x_1, y_1, 0), car.angles[1]);
    car.corner_b = car.origin + rotatepointaroundvector((0, 0, 1), (x_1, y_2, 0), car.angles[1]);
    car.corner_c = car.origin + rotatepointaroundvector((0, 0, 1), (x_2, y_2, 0), car.angles[1]);
    car.corner_d = car.origin + rotatepointaroundvector((0, 0, 1), (x_2, y_1, 0), car.angles[1]);
    car.var_27abfc12040d5908 = 1;
  }

  var_61f15908243423cc = getnoentvolumearray("elevator_occupancy_trig", "targetname");

  if(isDefined(var_61f15908243423cc) && var_61f15908243423cc.size > 0) {
    var_bf33d00c58d36fb9 = sortbydistance(var_61f15908243423cc, car.origin);
    closestidx = 0;
    tolerance = 48;
    car.occupancytrig = undefined;

    while(closestidx < var_bf33d00c58d36fb9.size) {
      if(distance_2d_squared(car.origin, var_bf33d00c58d36fb9[closestidx].origin) < tolerance * tolerance) {
        car.occupancytrig = var_bf33d00c58d36fb9[closestidx];
        break;
      }

      closestidx++;
    }

    car.var_27abfc12040d5908 = 1;
  }

  car forcenetfieldhighlod(1);
  car setmoveroptimized(1);
  car setmoverantilagged(1);
  car markkeyframedmover();
  elevator.car = car;
  elevator.floors[0] = elevatorset[groundfloorindex];
  elevator.floors[0].floornum = 0;
  elevator.floors[0].targetheight = elevator.car.origin[2];

  if(elevatorset.size > 1) {
    elevator.floors[1] = elevatorset[ter_op(groundfloorindex == 0, 1, 0)];
    elevator.floors[1].floornum = 1;
    elevator.floors[1].targetheight = elevator.car.origin[2] + elevator.floors[1].doormidpoint[2] - elevator.floors[0].doormidpoint[2];
  }

  elevator.currentfloor = 0;
  elevator.targetfloor = 0;
  level.elevators[level.elevators.size] = elevator;
  return elevator;
}

function elevatoronspawnplayer() {
  thread onspawnfinished();
}

function onspawnfinished() {
  self endon("death_or_disconnect");
  self waittill("giveLoadout");

  if(self.ti_spawn) {
    scripts\common\elevators::isinsideelevator();
  }
}

function isentitytouchingdoortrigger(ent) {
  if(!isent(ent)) {
    return;
  }

  if(isarray(self)) {
    foreach(elevator in self) {
      elevator thread isentitytouchingdoortrigger(ent);
    }

    return;
  }

  level endon("game_ended");
  ent endon("death");

  while(true) {
    if(isDefined(ent)) {
      if(isDefined(self.floors[self.currentfloor].trigger)) {
        self waittill("elevator_doors_unblocking");

        if(!isDefined(ent)) {
          return;
        }

        if(self.state == "moving") {
          if(ispointinvolume(ent.origin, self.floors[self.targetfloor].trigger)) {
            ent thread[[ent.elevatordoorsclosecallback]]();
          }
        }

        if(ispointinvolume(ent.origin, self.floors[self.currentfloor].trigger)) {
          ent thread[[ent.elevatordoorsclosecallback]]();
        }
      } else {
        return;
      }
    } else {
      return;
    }

    wait 1;
  }
}

function function_29de8f099a0a63df(ent) {
  if(!isent(ent)) {
    return;
  }

  if(isarray(self)) {
    foreach(elevator in self) {
      elevator thread function_29de8f099a0a63df(ent);
    }

    return;
  }

  level endon("game_ended");
  self endon("disconnect");
  ent endon("death");

  while(true) {
    if(isDefined(ent)) {
      if(isDefined(self.floors[self.currentfloor].trigger)) {
        self waittill("elevator_doors_closing");

        if(!isDefined(ent)) {
          return;
        }

        if(ispointinvolume(ent.origin, self.floors[self.currentfloor].trigger)) {
          self.floors[self.currentfloor].playerblocked = 1;
          self.floors[self.currentfloor] notify("player_blocked");
          self.floors[self.currentfloor] thread function_bd1cd7b7c484f126();
          wait 0.5;

          while(self.floors[self.currentfloor].playerblocked == 1) {
            if(!isDefined(ent)) {
              return;
            }

            if(ispointinvolume(ent.origin, self.floors[self.currentfloor].trigger)) {
              self.floors[self.currentfloor].playerblocked = 1;
              self.floors[self.currentfloor] notify("player_blocked");
              self.floors[self.currentfloor] thread function_bd1cd7b7c484f126();
            }

            wait 0.5;
          }
        }
      } else {
        break;
      }

      continue;
    }

    break;
  }
}

function deployablecover_isentitytouchingdoortrigger(ent) {
  if(!isent(ent)) {
    return;
  }

  if(isarray(self)) {
    foreach(elevator in self) {
      elevator thread deployablecover_isentitytouchingdoortrigger(ent);
    }

    return;
  }

  level endon("game_ended");
  ent endon("death");

  while(true) {
    if(isDefined(ent)) {
      if(isDefined(self.floors[self.currentfloor].trigger)) {
        self waittill("elevator_doors_unblocking");

        if(!isDefined(ent)) {
          return;
        }

        if(self.state == "moving") {
          if(ent.collision istouching(self.floors[self.targetfloor].trigger)) {
            ent thread[[ent.elevatordoorsclosecallback]]();
          }
        }

        if(ent.collision istouching(self.floors[self.currentfloor].trigger)) {
          ent thread[[ent.elevatordoorsclosecallback]]();
        }
      } else {
        return;
      }
    } else {
      return;
    }

    wait 1;
  }
}

function elevatortriggerfunc() {
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    self.trigger waittill("trigger", enttriggered);

    if(istrue(self.elevator.car.var_27abfc12040d5908)) {
      childthread elevatoroccupancytracking(enttriggered, self.elevator.car);
    }

    if(isPlayer(enttriggered) || isDefined(enttriggered.helperdronetype) || enttriggered scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      self.playerblocked = 1;
      self notify("player_blocked");
      thread function_bd1cd7b7c484f126();
    }

    waitframe();
  }
}

function function_bd1cd7b7c484f126() {
  self endon("player_blocked");
  wait 0.7;

  if(isDefined(self)) {
    self.playerblocked = 0;
    self notify("player_unblocked");
  }
}

function function_12e75ac514f84d03() {
  wait 1;
  thread function_580e82173ae3940c();
}

function elevatorextbuttonPressed(instance, part, state, player, bautouse, usestring) {
  if(isDefined(instance.floornum)) {
    if(instance.elevator.currentfloor == instance.floornum) {
      instance.elevator.state = "doors_open";
    } else {
      instance.elevator.targetfloor = instance.floornum;
    }

    instance.elevator notify("stop_waiting");
    instance.elevator.floors[instance.elevator.targetfloor] setscriptablepartstate("elevator_ext_button", "disabled");

    if(instance.elevator.currentfloor > instance.elevator.targetfloor) {
      instance.elevator.floors[instance.elevator.targetfloor] setscriptablepartstate("elevator_button_lights", "up");
      return;
    }

    instance.elevator.floors[instance.elevator.targetfloor] setscriptablepartstate("elevator_button_lights", "down");
  }
}

function function_d99e32e6787622fe(instance, part, state, player, bautouse, usestring) {
  if(isDefined(player)) {
    player playSound("mp_elevator_button_press");
  }

  instance.entity.elevator.targetfloor = ter_op(instance.entity.elevator.currentfloor == 0, 1, 0);
  instance.entity.elevator notify("stop_waiting");
}

function function_c327c9e30f9df682() {
  foreach(part in self.parts) {
    if(isDefined(part.info)) {
      part.owner = self;
      self.floors[part.floornum] = part;
    }
  }
}

function elevatorbuttonPressed(instance, part, state, player, bautouse, usestring) {
  if(isDefined(instance.floornum)) {
    if(instance.floornum == 0) {
      instance.owner.targetfloor = ter_op(instance.owner.currentfloor == 1, 2, 1);
    } else if(instance.owner.currentfloor == instance.floornum) {
      instance.owner.state = "doors_open";
    } else {
      instance.owner.targetfloor = instance.floornum;
    }

    instance.owner notify("stop_waiting");
  }
}

function elevatordooropen() {
  foreach(door in self.doors) {
    self.open = 1;
    door.open = 1;
    door setscriptablepartstate("door", "open", 0);
  }

  if(isDefined(self.indicator)) {
    self.indicator setscriptablepartstate("model", "arrived");
  }
}

function elevatordoorclose() {
  self.elevator endon("emergency_block");

  foreach(door in self.doors) {
    self.open = 0;
    door.open = 0;
    door setscriptablepartstate("door", "closed", 0);
  }
}

function function_580e82173ae3940c() {
  while(true) {
    self[[level.elevatorsfuncs[self.state]]]();
  }
}

function function_4497ec9c55f12123() {
  if(self.targetfloor != self.currentfloor) {
    if(self.floors[self.currentfloor].open) {
      self.state = "doors_closing";
    } else {
      self.state = "moving";
    }

    return;
  }

  self waittill("stop_waiting");
}

function function_ec009a967d1d5eb9() {
  self.floors[self.currentfloor] setscriptablepartstate("elevator_ext_button", "disabled");
  self.floors[self.currentfloor] setscriptablepartstate("elevator_button_lights", "off");
  self notify("elevator_doors_unblocking");
  self.floors[self.currentfloor] thread elevatordooropen();
  self.car setscriptablepartstate("door_sounds", "open");

  if(self.car.var_ef04438af292c145 && self.currentfloor != 0) {
    self.car thread anim_single_solo(self.car, "open_back");
  } else {
    self.car thread anim_single_solo(self.car, "open");
  }

  wait 5;
  self.state = "waiting";
}

function function_8b680b3ef155fc34() {
  self endon("emergency_block");
  self notify("elevator_doors_closing");
  wait 0.01;

  if(self.floors[self.currentfloor].playerblocked == 1) {
    thread function_5bfc9aae53c14056();
    self.floors[self.currentfloor] waittill("player_unblocked");
  }

  self notify("elevator_doors_unblocking");
  thread function_f99e0077b2350e7();
  wait 0.01;
  self.car setscriptablepartstate("door_sounds", "close");
  self.floors[self.currentfloor] thread elevatordoorclose();

  if(self.car.var_ef04438af292c145 && self.currentfloor != 0) {
    str_anim = "close_back";
  } else {
    str_anim = "close";
  }

  self.car thread anim_single_solo(self.car, str_anim);
  var_eca01e2e30413714 = getanimlength(level.scr_anim[self.car.animname][str_anim]);
  self.car waittill_notify_or_timeout(str_anim, var_eca01e2e30413714);
  waitframe();
  waitframe();
  waitframe();
  self notify("elevator_stop_block");
  self notify("elevator_closed");
  self.state = "waiting";
  self.floors[self.currentfloor] setscriptablepartstate("elevator_ext_button", "usable");
}

function fsm_elevatormove() {
  for(i = 0; i < self.floors.size; i++) {
    if(isDefined(self.floors[i].indicator)) {
      if(self.floors[i].floornum == self.targetfloor) {
        if(self.currentfloor > self.targetfloor) {
          self.floors[i].indicator setscriptablepartstate("model", "down");
        } else {
          self.floors[i].indicator setscriptablepartstate("model", "up");
        }

        continue;
      }

      if(self.floors[i].floornum > self.targetfloor) {
        self.floors[i].indicator setscriptablepartstate("model", "down");
        continue;
      }

      self.floors[i].indicator setscriptablepartstate("model", "up");
    }
  }

  totalheight = abs(self.floors[self.targetfloor].targetheight - self.floors[self.currentfloor].targetheight);

  if(isDefined(self.car.n_travel_time)) {
    assertex(self.car.n_travel_time >= self.car.n_accel_time + self.car.var_23e93511918b6091, "<dev string:x8c>" + self.car.n_accel_time + self.car.n_accel_time + "<dev string:xb6>");

    if(self.car.n_travel_time >= self.car.n_accel_time + self.car.var_23e93511918b6091) {
      duration = self.car.n_travel_time;
    }
  }

  if(!isDefined(duration)) {
    duration = max(totalheight / 150, 4.25);
  }

  foreach(ent in self.car.occupants) {
    if(isPlayer(ent) && isalive(ent)) {
      ent thread function_7995b0b9c011087(duration);
    }
  }

  targetpos = (self.car.origin[0], self.car.origin[1], self.floors[self.targetfloor].targetheight);
  self.car moveTo(targetpos, duration, self.car.n_accel_time, self.car.var_23e93511918b6091);
  self.car setscriptablepartstate("elevator_sounds", "on");
  wait duration;
  self.car setscriptablepartstate("elevator_sounds", "off");
  wait 0.5;
  self.currentfloor = self.targetfloor;
  self.state = "doors_open";

  for(i = 0; i < self.floors.size; i++) {
    if(isDefined(self.floors[i].indicator)) {
      if(self.floors[i].floornum != self.currentfloor) {
        self.floors[i].indicator setscriptablepartstate("model", "off");
      }
    }
  }
}

function function_7995b0b9c011087(duration) {
  self endon("death_or_disconnect");
  self allowprone(0);
  wait duration + 0.5;
  self allowprone(1);
}

function function_f99e0077b2350e7() {
  self endon("elevator_closed");
  self endon("elevator_doors_closing");
  self endon("elevator_stop_block");

  while(true) {
    if(self.floors[self.currentfloor].playerblocked == 1) {
      self notify("emergency_block");
      self.state = "doors_open";
      wait 0.025;
      self.state = "doors_closing";
      return;
    }

    waitframe();
  }
}

function function_ef19d9446fc2352(num) {
  return self.floors[num].child.child.child.origin;
}

function function_c78df968f4751498() {
  function_bc48943904164e29("elevator_button_floor_01");
  function_bc48943904164e29("elevator_button_floor_02");
  function_bc48943904164e29("elevator_button_00_inside");
}

function function_bc48943904164e29(str) {
  oldpart = self.parts[str];
  buttonpos = oldpart.origin;
  buttonangles = oldpart.angles + (90, 0, 0);
  button = spawnscriptable("scriptable_test_button", buttonpos, buttonangles);
  button.parent = oldpart.parent;
  button.child = oldpart.child;
  button.originalpos = oldpart.originalpos;
  button.info = str;
  button.floornum = int(oldpart.script_label);

  if(isDefined(oldpart.children)) {
    button.children = oldpart.children;
  }

  self.parts[str] = button;
}

#using_animtree("script_model");

function script_model_anims(subtype) {
  level.scr_animtree["elevator"] = #animtree;
  level.scr_anim["elevator"]["close"] = % iw9_elevator_int_door_close;
  level.scr_eventanim["elevator"]["close"] = % "iw9_elevator_int_door_close";
  level.scr_animtree["elevator"] = #animtree;
  level.scr_anim["elevator"]["open"] = % iw9_elevator_int_door_open;
  level.scr_eventanim["elevator"]["open"] = % "iw9_elevator_int_door_open";
  level.scr_animtree["elevator_double"] = #animtree;
  level.scr_anim["elevator_double"]["close"] = % t10_ava_building_elevator_double_int_door_close;
  level.scr_eventanim["elevator_double"]["close"] = % "t10_ava_building_elevator_double_int_door_close";
  level.scr_animtree["elevator_double"] = #animtree;
  level.scr_anim["elevator_double"]["open"] = % t10_ava_building_elevator_double_int_door_open;
  level.scr_eventanim["elevator_double"]["open"] = % "t10_ava_building_elevator_double_int_door_open";
  level.scr_animtree["elevator_double"] = #animtree;
  level.scr_anim["elevator_double"]["close_back"] = % t10_ava_building_elevator_double_int_back_door_close;
  level.scr_eventanim["elevator_double"]["close_back"] = % "t10_ava_building_elevator_double_int_back_door_close";
  level.scr_animtree["elevator_double"] = #animtree;
  level.scr_anim["elevator_double"]["open_back"] = % t10_ava_building_elevator_double_int_back_door_open;
  level.scr_eventanim["elevator_double"]["open_back"] = % "t10_ava_building_elevator_double_int_back_door_open";
  level.scr_animtree["elevator_small"] = #animtree;
  level.scr_anim["elevator_small"]["close"] = % t10_ava_machinery_elevator_sm_01_close;
  level.scr_eventanim["elevator_small"]["close"] = % "t10_ava_machinery_elevator_sm_01_close";
  level.scr_animtree["elevator_small"] = #animtree;
  level.scr_anim["elevator_small"]["open"] = % t10_ava_machinery_elevator_sm_01_open;
  level.scr_eventanim["elevator_small"]["open"] = % "t10_ava_machinery_elevator_sm_01_open";
  level.scr_animtree["elevator_small_double"] = #animtree;
  level.scr_anim["elevator_small_double"]["close"] = % t10_ava_machinery_elevator_dbl_01_front_close;
  level.scr_eventanim["elevator_small_double"]["close"] = % "t10_ava_machinery_elevator_dbl_01_front_close";
  level.scr_animtree["elevator_small_double"] = #animtree;
  level.scr_anim["elevator_small_double"]["open"] = % t10_ava_machinery_elevator_dbl_01_front_open;
  level.scr_eventanim["elevator_small_double"]["open"] = % "t10_ava_machinery_elevator_dbl_01_front_open";
  level.scr_animtree["elevator_small_double"] = #animtree;
  level.scr_anim["elevator_small_double"]["close_back"] = % t10_ava_machinery_elevator_dbl_01_rear_close;
  level.scr_eventanim["elevator_small_double"]["close_back"] = % "t10_ava_machinery_elevator_dbl_01_rear_close";
  level.scr_animtree["elevator_small_double"] = #animtree;
  level.scr_anim["elevator_small_double"]["open_back"] = % t10_ava_machinery_elevator_dbl_01_rear_open;
  level.scr_eventanim["elevator_small_double"]["open_back"] = % "t10_ava_machinery_elevator_dbl_01_rear_open";
}

function elevatoroccupancytracking(enttriggered, car) {
  enttriggered notify("elevator_occupancy_tracking");
  enttriggered endon("elevator_occupancy_tracking");
  enttriggered endon("death");
  enttriggered endon("disconnect");
  short_interval = 0.1;
  long_interval = 1.5;
  var_91ccf825cd08c4fa = long_interval;
  var_1da4fdb9cce88177 = 140;

  while(isDefined(enttriggered)) {
    car function_e7de8f7b4f13cd26(enttriggered, 1);

    while(!enttriggered isinsideelevator(car)) {
      wait short_interval;
      var_91ccf825cd08c4fa -= short_interval;

      if(var_91ccf825cd08c4fa < 0) {
        var_91ccf825cd08c4fa = long_interval;

        if(distance_2d_squared(enttriggered.origin, car.origin) > var_1da4fdb9cce88177 * var_1da4fdb9cce88177) {
          return;
        }
      }
    }

    car function_e7de8f7b4f13cd26(enttriggered);

    while(enttriggered isinsideelevator(car)) {
      wait short_interval;
    }
  }
}

function isinsideelevator(car) {
  if(!isDefined(self) || !isalive(self)) {
    return 0;
  }

  if(!isDefined(level.elevators)) {
    return 0;
  }

  if(!isDefined(car)) {
    elevatorcars = [];

    foreach(elevator in level.elevators) {
      elevatorcars[elevatorcars.size] = elevator.car;
    }

    car = getclosest(self.origin, elevatorcars);

    if(!isDefined(car)) {
      return 0;
    }
  }

  if(!istrue(car.var_27abfc12040d5908)) {
    return 0;
  }

  if(getdvarint(@ "hash_24b1d20863cdd66a", 0) == 1) {
    if(isDefined(car.occupancytrig) && ispointinvolume(self.origin, car.occupancytrig)) {
      if(!istrue(self.isinsideelevator)) {
        car function_e7de8f7b4f13cd26(self);
      }

      return 1;
    }

    if(isDefined(car.corner_a)) {
      z_padding = 16;

      if(self.origin[2] < car.origin[2] - z_padding && self.origin[2] > car.origin[2] + car.carheight + z_padding) {
        return 0;
      }

      if(function_cba565314ac6a79e(self.origin, car.corner_a, car.corner_b, car.corner_c, car.corner_d)) {
        if(!istrue(self.isinsideelevator)) {
          car function_e7de8f7b4f13cd26(self);
        }

        return 1;
      }
    }

    return 0;
  }

  if(isDefined(car.occupancytrig) && !ispointinvolume(self.origin, car.occupancytrig)) {
    return 0;
  }

  if(isDefined(car.corner_a) && !function_cba565314ac6a79e(self.origin, car.corner_a, car.corner_b, car.corner_c, car.corner_d)) {
    return 0;
  }

  zpadding = 16;
  var_fcf847baec7225bb = car.elevator.floors[0].targetheight - zpadding;
  var_700c97bb40709445 = car.elevator.floors[1].targetheight + car.carheight + 5;

  if(self.origin[2] <= car.origin[2] - zpadding || self.origin[2] >= car.origin[2] + car.carheight) {
    if(self.origin[2] >= var_fcf847baec7225bb && self.origin[2] <= var_700c97bb40709445) {
      glitchedorigin = self.origin;
      teleporttoorigin = (self.origin[0], self.origin[1], car.origin[2]);
      teleporttoorigin = vectorlerp(car.origin, teleporttoorigin, 0.85) + (0, 0, zpadding);

      if(isDefined(car.occupancytrig) && !ispointinvolume(self.origin, car.occupancytrig) || isDefined(car.corner_a) && !function_cba565314ac6a79e(self.origin, car.corner_a, car.corner_b, car.corner_c, car.corner_d)) {
        teleporttoorigin = car.origin + (randomintrange(-48, 48), randomintrange(-48, 48), zpadding);
      }

      print3d(glitchedorigin, "<dev string:xbc>", (1, 0.25, 0), 1, 0.25, 1000);
      line(glitchedorigin + (-4, -4, 0), glitchedorigin + (4, 4, 0), (1, 0.25, 0), 1, 0, 1000);
      line(glitchedorigin + (-4, 4, 0), glitchedorigin + (4, -4, 0), (1, 0.25, 0), 1, 0, 1000);
      line(teleporttoorigin, glitchedorigin, (1, 1, 0), 1, 0, 1000);
      line(teleporttoorigin + (-4, -4, 0), teleporttoorigin + (4, 4, 0), (0, 1, 1), 1, 0, 1000);
      line(teleporttoorigin + (-4, 4, 0), teleporttoorigin + (4, -4, 0), (0, 1, 1), 1, 0, 1000);
      print3d(teleporttoorigin, "<dev string:xc8>", (0, 1, 1), 1, 0.25, 1000);

      self setOrigin(teleporttoorigin);
      return 1;
    }

    return 0;
  }

  if(!istrue(self.isinsideelevator)) {
    car function_e7de8f7b4f13cd26(self);
  }

  return 1;
}

function function_e7de8f7b4f13cd26(occupant, remove_occupant) {
  self.occupants = function_fdc9d5557c53078e(self.occupants);

  if(!isDefined(occupant)) {
    return;
  }

  if(istrue(remove_occupant)) {
    occupant.isinsideelevator = 0;
    occupant.var_a9f709a20b6aa136 = undefined;
    self.occupants = array_remove(self.occupants, occupant);
    return;
  }

  thread removeoccupantondeath(occupant);
  occupant.isinsideelevator = 1;
  occupant.var_a9f709a20b6aa136 = self;

  if(!array_contains(self.occupants, occupant)) {
    self.occupants[self.occupants.size] = occupant;
  }
}

function removeoccupantondeath(occupant) {
  occupant notify("removeOccupantOnDeath");
  occupant endon("removeOccupantOnDeath");
  occupant waittill("death_or_disconnect");

  if(isDefined(occupant)) {
    occupant.isinsideelevator = 0;
    occupant.var_a9f709a20b6aa136 = undefined;
    self.occupants = array_remove(self.occupants, occupant);
    return;
  }

  self.occupants = array_removeundefined(self.occupants);
}

function function_cba565314ac6a79e(point, corner_a, corner_b, corner_c, corner_d) {
  corner_a = (corner_a[0], corner_a[1], 0);
  corner_b = (corner_b[0], corner_b[1], 0);
  corner_c = (corner_c[0], corner_c[1], 0);
  corner_d = (corner_d[0], corner_d[1], 0);
  point = (point[0], point[1], 0);
  center = vectorlerp(corner_a, corner_c, 0.5);
  var_8999387886088d53 = pointonsegmentnearesttopoint(corner_a, corner_b, point);
  var_899d5f78860cd8ef = pointonsegmentnearesttopoint(corner_b, corner_c, point);

  if(distance_2d_squared(center, point) <= distance_2d_squared(center, var_8999387886088d53) && distance_2d_squared(center, point) <= distance_2d_squared(center, var_899d5f78860cd8ef)) {
    return true;
  }

  return false;
}

function function_5bfc9aae53c14056() {
  level endon("game_ended");
  self endon("elevator_doors_closing");
  self endon("disconnect");

  while(self.floors[self.currentfloor].playerblocked == 1) {
    self.car playSound("mp_elevator_open");

    if(self.floors[self.currentfloor].playerblocked == 0) {
      break;
    }

    wait 3;
  }
}

function function_49197cd063a740ea(callbackfunction) {
  self.elevatordoorsclosecallback = callbackfunction;
}