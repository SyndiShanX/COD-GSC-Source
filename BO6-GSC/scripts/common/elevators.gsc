/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\elevators.gsc
****************************************/

#using scripts\common\anim;
#using scripts\common\vehicle;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#namespace elevators;

function autoexec initelevators() {
  if(!istrue(game["\x0eU\xa3zQc\xd8\x1dM\xd4\x1b\xa1m"])) {
    scriptable::scriptable_addpostinitcallback(&initelevatorscallback);
  }
}

function private initelevatorscallback() {
  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  scriptable::scriptable_addusedcallbackbypart("1\xea:\xe8\xde7", &elevatorbuttonpressed);
  scriptable::scriptable_addusedcallbackbypart("\xc0\xc6\xd4\xfd\x80\xe4\x151\xe4'\xac\xc4u\x82).$\xc9\x05", &elevatorextbuttonpressed);
  scriptable::scriptable_addusedcallbackbypart("\xefm?)\xc1\xc5X\x88\\\xa9\xc4VW\xaeDM\xa8\xb2\x7f", &function_fc79ea5198fe17ff);
  scriptable::scriptable_addusedcallbackbypart("\x958\xf9\x89\xa8\xce\xcfj\x03\xf7\x9d\xc8\xc0\xa1Q\xde]\xc0\x81\xc0\x80\x90\x1f\xfa\x9a\x9f", &function_fc79ea5198fe17ff);
  level.elevatorsfuncs = [];
  level.elevatorsfuncs["\xc3\x969$\xc1\xd6\xfd"] = &function_3aca965d4b58f74e;
  level.elevatorsfuncs["\xf5\xd9m\xd3x\xe1\x8b\xec\xb8\x0f"] = &function_fe3561f50d2764ac;
  level.elevatorsfuncs["ax\xb6I\xb1\xae\x8a\x12\x91\xa6\x18\xda\x99"] = &function_9cfadb56378e381d;
  level.elevatorsfuncs["[\xb7\xecZ\xb9\x9d"] = &fsm_elevatormove;
  level.elevators = [];
  level.elevatorstops = [];
  level.elevatoronspawnplayer = &elevatoronspawnplayer;
  script_model_anims("\x91\xca\xcc\v\xab\xd8:");
  elevatorstops = getentitylessscriptablearray("\x95\xd8YvX\x8e\xb7\xe4_s\xe8{p", #script_noteworthy);

  foreach(stop in elevatorstops) {
    initelevatorstop(stop);
  }

  elevatorcars = utility::getStructArray("\xc4R\xb4\xd8\x8fo\x10m\x04\x91\x05\x06", "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");

  foreach(elevatorset in level.elevatorstops) {
    if(elevatorset.size != 2) {
      continue;
    }

    elevator = initelevatorset(elevatorset, elevatorcars);

    if(isDefined(elevator)) {
      elevator thread function_b9e7952fb498c0c6();
    }
  }

  utility::registersharedfunc(#"game", #"isentitytouchingdoortrigger", &isentitytouchingdoortrigger);
  utility::flag_set("\xbb\x18\x93%\x9f\x98C6\x14gX\x84C\x1f");
}

function initelevatorstop(stop) {
  stop.open = 0;
  [stop.indicator] = getentitylessscriptablearray(stop.target, #targetname);
  stop.doors = getentitylessscriptablearray(stop.indicator.target, #targetname);
  stop.entsblocking = [];

  if(stop.doors.size > 0) {
    s_anchor = undefined;

    if(isDefined(stop.doors[0].target)) {
      s_anchor = utility::getStruct(stop.doors[0].target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    }

    assert(stop.doors.size <= 2, "<dev string:x24>");

    foreach(door in stop.doors) {
      door.open = 0;
    }

    if(stop.doors.size == 1) {
      stop.doormidpoint = stop.doors[0].origin;
    } else {
      stop.doormidpoint = averagepoint([stop.doors[0].origin, stop.doors[1].origin]);
    }
  } else {
    if(isDefined(stop.target)) {
      s_anchor = utility::getStruct(stop.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    }

    if(!isDefined(s_anchor)) {
      s_anchor = stop;
    }

    stop.doormidpoint = s_anchor.origin;
  }

  if(isDefined(s_anchor)) {
    stop.posstring = s_anchor.origin[0] + "\x16" + s_anchor.origin[1];
  } else {
    stop.posstring = stop.doormidpoint[0] + "\x16" + stop.doormidpoint[1];
  }

  if(!isDefined(level.elevatorstops[stop.posstring])) {
    level.elevatorstops[stop.posstring] = [];
  }

  level.elevatorstops[stop.posstring][level.elevatorstops[stop.posstring].size] = stop;
  stop.playerblocked = 0;

  if(isDefined(stop.doors[0].target)) {
    if(isDefined(s_anchor)) {
      noenttrigger = function_ac311f3d6717d47d(s_anchor.target, #targetname);
    } else {
      noenttrigger = function_ac311f3d6717d47d(stop.doors[0].target, #targetname);
    }

    stop.trigger = noenttrigger[0];

    if(isDefined(stop.trigger)) {
      stop thread elevatortriggerfunc();
    }
  }
}

function elevatoronspawnplayer() {
  thread onspawnfinished();
}

function private function_e03b67522536c9d(equipment_ent) {
  if(isDefined(equipment_ent.equipmentref)) {
    switch (equipment_ent.equipmentref) {
      case #"hash_4a85ee2b82965fe2":
      case #"hash_aa60ec2aec479ec8":
      case #"hash_c848458cca24d656":
      case #"hash_eb1d3d54e9981d38":
        return true;
      default:
        return false;
    }
  }

  return false;
}

function crush_watcher() {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\x1e\xfd\xd1\xa2\a");
  touchingradiuscheck = 200;
  var_48a4194baef19a7f = 10000;
  crusher = self.parent;
  var_77ec64413ebfc3bb = 12;
  direction_vec = (0, 0, 0);
  point = (0, 0, 0);
  angles = (0, 0, 0);
  normal = (0, 0, 0);
  modelname = "";
  tagname = "";
  partname = "";
  idflags = undefined;

  while(true) {
    if(isDefined(crusher.moving) && crusher.moving == #"moving_down") {
      entarray = getentarrayinradius(undefined, undefined, self.origin, touchingradiuscheck);
      touching = self getistouchingentities(entarray);

      foreach(touchent in touching) {
        if(isalive(touchent) && isPlayer(touchent)) {
          attacker = isDefined(crusher.lastplayerused) && crusher.lastplayerused.team != touchent.team ? crusher.lastplayerused : self;
          touchent.nocorpse = 1;
          touchent kill(self.origin, attacker, self, "\xc0o\x90Fs%]\xfe\xd8");
        }

        damageable = function_e03b67522536c9d(touchent);

        if(!isalive(touchent) && !touchent getcandamage() && !damageable) {
          continue;
        }

        if(touchent.origin[2] > crusher.origin[2] - var_77ec64413ebfc3bb && !damageable) {
          continue;
        }

        touchent.nocorpse = 1;

        if(isDefined(level.taccover_destroy) && isDefined(touchent.equipmentref) && touchent.equipmentref == "\x81\x9eP>\x8eC\xd4\xcd\x0f\xf6\x13\x05\x1a\x93\x06") {
          touchent[[level.taccover_destroy]](1, 1, 1);
          continue;
        }

        if(isDefined(touchent.classname) && touchent.classname == "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e") {
          touchent.dontspawnhusk = 1;
          touchent dodamage(touchent.health + var_48a4194baef19a7f, self.origin, self, self, "\xc0o\x90Fs%]\xfe\xd8");
          continue;
        }

        if(touchent getcandamage() && touchent.health <= 0) {
          touchent notify("\xf4\xae\x96_d\xc2\x95\xc6\x0e\xc0Q\x80\x8f\xe0\xcfej");
          touchent notify("\fU`\xc0y\x95", touchent.health + var_48a4194baef19a7f, undefined, direction_vec, point, "\xc0o\x90Fs%]\xfe\xd8", modelname, tagname, partname, idflags, undefined, self.origin, angles, normal, undefined);
          continue;
        }

        touchent kill(self.origin, self, self, "\xc0o\x90Fs%]\xfe\xd8");
      }
    }

    wait 0.1;
  }
}

function initelevatorset(elevatorset, elevatorcars, overridemodel) {
  elevator = spawnStruct();
  elevator.parts = [];
  elevator.floors = [];
  elevator.state = "\xf5\xd9m\xd3x\xe1\x8b\xec\xb8\x0f";

  if(elevatorset.size > 1) {
    groundfloorindex = elevatorset[0].origin[2] < elevatorset[1].origin[2] ? 0 : 1;
  } else {
    groundfloorindex = 0;
  }

  foreach(stop in elevatorset) {
    stop.elevator = elevator;
  }

  checkorigin = elevatorset[groundfloorindex].origin;
  mindist = undefined;
  targetcar = undefined;
  var_359253bfe053c819 = undefined;

  foreach(car in elevatorcars) {
    if(!isDefined(mindist)) {
      mindist = distancesquared(car.origin, checkorigin);
      targetcar = car;
      var_359253bfe053c819 = car.targetname;
      continue;
    }

    dist = distancesquared(car.origin, checkorigin);

    if(dist < mindist) {
      mindist = dist;
      targetcar = car;
      var_359253bfe053c819 = car.targetname;
    }
  }

  car = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", targetcar.origin);
  car.angles = targetcar.angles;
  car.var_359253bfe053c819 = targetcar.targetname;
  car.str_model_name = targetcar.script_modelname;
  car.var_3c11ec9873652bec = targetcar.var_5a44ec479d1a28ea;
  car.var_4fda8691744d501c = 0;

  if(isDefined(targetcar.target)) {
    crusherents = getEntArray(targetcar.target, #targetname);

    foreach(crusherent in crusherents) {
      if(crusherent.classname == "E\x03\xae\xad\x7f\xcc\xa9\x17\xda\xb0K\xa4s\xeb\xfb\xf7") {
        crusherent enablelinkTo();
        crusherent linkTo(car);
        crusherent.parent = car;
        crusherent.iscrusher = 1;
        crusherent thread crush_watcher();
      }
    }
  }

  accelerationtime = level.elevatoracceltime ?? 2;
  decelerationtime = level.elevatordeceltime ?? 2;

  if(isDefined(targetcar.script_parameters)) {
    var_1b3ff8230256f7ba = strtok(targetcar.script_parameters, "\x16");
    car.n_travel_time = float(var_1b3ff8230256f7ba[0]);

    if(var_1b3ff8230256f7ba.size >= 3) {
      car.var_2923c9a57f9987db = level.elevatoracceltime ?? float(var_1b3ff8230256f7ba[1]);
      car.var_f9db675dc1879d40 = level.elevatordeceltime ?? float(var_1b3ff8230256f7ba[2]);
    } else if(var_1b3ff8230256f7ba.size == 2) {
      car.var_2923c9a57f9987db = level.elevatoracceltime ?? float(var_1b3ff8230256f7ba[1]);
      car.var_f9db675dc1879d40 = car.var_2923c9a57f9987db;
    } else if(car.n_travel_time >= accelerationtime + decelerationtime) {
      car.var_2923c9a57f9987db = accelerationtime;
      car.var_f9db675dc1879d40 = decelerationtime;
    } else {
      car.var_2923c9a57f9987db = 0;
      car.var_f9db675dc1879d40 = 0;
    }
  } else {
    car.var_2923c9a57f9987db = accelerationtime;
    car.var_f9db675dc1879d40 = decelerationtime;
  }

  if(isDefined(targetcar.script_cost)) {
    elevator.script_cost = targetcar.script_cost;
  }

  if(!isDefined(car.var_359253bfe053c819)) {
    car.var_359253bfe053c819 = "\x91\xca\xcc\v\xab\xd8:";
  }

  switch (car.var_359253bfe053c819) {
    case #"hash_dfb267e42bb20045":
      var_a10debb551716dcb = "M\x8c\xbdg\xd2uL\xe8F\x04\x11\xbe\xfe\x8e0\xc3\xd9\">\xf6n\x17\x06\xc0^p7\xba\xb6\xf76\xc5\xd8\b\x17\xbf+\x96\x12]";
      car.animname = "s>*\xadd\x87\xe7\xb7[\xe2)\x05[}_";
      car.var_42e3c04591ee0b10 = 1;
      break;
    case #"hash_5971965ed985a26c":
      var_a10debb551716dcb = "\xb7w\x0f\xef\xfbA\xbb\x86S*\xc7\x12\x87,S-\x93\xfb\xbf.\xda\x02\x9c\x81j\a\x03\xd3\xb8~\xc1\xbaV:\xac\xe5K\x83\xfc\xf6\xcdR\x06\xaa\xbf \xac\xbc\x85\x95p\x14\xca";
      car.animname = " 4\xfcN\xd4\xeb\xd8\\Yi\xedS\xdaf";
      car.var_42e3c04591ee0b10 = 0;
      break;
    case #"hash_6bf513acc2adb471":
      var_a10debb551716dcb = "\xe2\xa4!\xe3\xd0\xa7\xeb\x91\x16\xf81\xb6\x96\xe7z\xb8!\x1b\xd2\xbak\x03\xf3\x9eV|:L\x81\xd5\xfd{$B\xf6\x1c\x88\x1bJ\x8d\xdf\x1b\xe0m\xfa\xcc\xeb\x7f\xaf\xd2_\xea\x04";
      car.animname = "\x01x\x8a\xe3\xf2\f\xf5\x84\xf76\xae\xd8\x0ee.m\x9d\xae~-\x1e";
      car.var_42e3c04591ee0b10 = 1;
      break;
    case #"hash_acc660ae6a3e8212":
      car.animname = undefined;
      car.var_42e3c04591ee0b10 = 0;
      break;
    default:
      var_a10debb551716dcb = overridemodel ?? "\x13\xea\xa5cd-7\xec\xd7\xe6\x85La\xbeY\x1b\xac\xb3\xc2t\xde\xe4\xd7ne\xa3\xeb\x96\xe6\xa3";
      car.animname = "[\xa3y\x10lNz\xda";
      car.var_42e3c04591ee0b10 = 0;
      break;
  }

  if(!isDefined(car.str_model_name)) {
    car.str_model_name = var_a10debb551716dcb;
  }

  if(isDefined(car.var_3c11ec9873652bec)) {
    car.str_model_name = car.var_3c11ec9873652bec + "W\xd3" + car.str_model_name;
  }

  car setModel(car.str_model_name);

  if(isDefined(car.animname)) {
    car animation::setanimtree();
  }

  assert(car isscriptable(), "<dev string:x50>");

  if(!car isscriptable()) {
    return;
  }

  if(car getscriptablehaspart("\x8f\xf9&\x13\xd4\xeb")) {
    car setscriptablepartstate("\x8f\xf9&\x13\xd4\xeb", "\xb8\"");
  }

  car.elevator = elevator;
  car.occupants = [];
  car.var_a14873faa8c394d9 = 0;

  if(isDefined(targetcar.target)) {
    corner_a = utility::getStruct(targetcar.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

    if(isDefined(corner_a)) {
      corner_b = utility::getStruct(corner_a.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

      if(isDefined(corner_b)) {
        corner_c = utility::getStruct(corner_b.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

        if(isDefined(corner_c)) {
          corner_d = utility::getStruct(corner_c.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

          if(isDefined(corner_d)) {
            car.carheight = 144;
            car.corner_a = corner_a.origin;
            car.corner_b = corner_b.origin;
            car.corner_c = corner_c.origin;
            car.corner_d = corner_d.origin;
            car.var_a14873faa8c394d9 = 1;
          }
        }
      }
    }
  }

  if(!car.var_a14873faa8c394d9 && car.model == "\x13\xea\xa5cd-7\xec\xd7\xe6\x85La\xbeY\x1b\xac\xb3\xc2t\xde\xe4\xd7ne\xa3\xeb\x96\xe6\xa3") {
    x_1 = -84;
    x_2 = 76;
    y_1 = -88;
    y_2 = 88;
    car.carheight = 144;
    car.corner_a = car.origin + rotatepointaroundvector((0, 0, 1), (x_1, y_1, 0), car.angles[1]);
    car.corner_b = car.origin + rotatepointaroundvector((0, 0, 1), (x_1, y_2, 0), car.angles[1]);
    car.corner_c = car.origin + rotatepointaroundvector((0, 0, 1), (x_2, y_2, 0), car.angles[1]);
    car.corner_d = car.origin + rotatepointaroundvector((0, 0, 1), (x_2, y_1, 0), car.angles[1]);
    car.var_a14873faa8c394d9 = 1;
  }

  var_fdf0600a3b27f825 = function_ac311f3d6717d47d("\x99\xc2\xf7) ,\xbey\xbc9p\xab\xc0\x02\x02I\x02\xeby\xf7\x01\xf66", #targetname);

  if(isDefined(var_fdf0600a3b27f825) && var_fdf0600a3b27f825.size > 0) {
    var_3b2a83cef0495ec = sortbydistance(var_fdf0600a3b27f825, car.origin);
    closestidx = 0;
    tolerance = 48;
    car.occupancytrig = undefined;

    while(closestidx < var_3b2a83cef0495ec.size) {
      if(utility::distance_2d_squared(car.origin, var_3b2a83cef0495ec[closestidx].origin) < tolerance * tolerance) {
        car.occupancytrig = var_3b2a83cef0495ec[closestidx];
        break;
      }

      closestidx++;
    }

    car.var_a14873faa8c394d9 = 1;
  }

  car forcenetfieldhighlod(1);
  car setmoveroptimized(1);
  car setmoverantilagged(1);
  car markkeyframedmover();
  elevator.car = car;
  elevator.currentfloor = 0;
  elevator.targetfloor = 0;
  bottomheight = undefined;
  topheight = undefined;

  if(elevatorset.size > 1) {
    var_a37174bb375a9456 = abs(elevatorset[groundfloorindex].doormidpoint[2] - elevator.car.origin[2]) < abs(elevatorset[groundfloorindex == 0 ? 1 : 0].doormidpoint[2] - elevator.car.origin[2]);
    topheightoffset = elevatorset[groundfloorindex == 0 ? 1 : 0].doormidpoint[2] - elevatorset[groundfloorindex].doormidpoint[2];

    if(!var_a37174bb375a9456) {
      bottomheight = elevator.car.origin[2] - topheightoffset;
      topheight = elevator.car.origin[2];
      elevator.currentfloor = 1;
      elevator.targetfloor = 1;
    } else {
      bottomheight = elevator.car.origin[2];
      topheight = elevator.car.origin[2] + topheightoffset;
    }
  }

  elevator.floors[0] = elevatorset[groundfloorindex];
  elevator.floors[0].floornum = 0;
  elevator.floors[0].targetheight = bottomheight;

  if(elevatorset.size > 1) {
    elevator.floors[1] = elevatorset[groundfloorindex == 0 ? 1 : 0];
    elevator.floors[1].floornum = 1;
    elevator.floors[1].targetheight = topheight;
  }

  level.elevators[level.elevators.size] = elevator;
  return elevator;
}

function onspawnfinished() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self waittill("\xe5\xf2\xaeE'\xdb\xf6\xe9\xfb\xa3\xb1");

  if(self.ti_spawn) {
    isinsideelevator();
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

  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  ent endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    if(isDefined(ent)) {
      if(isDefined(self.floors[self.currentfloor].trigger)) {
        self waittill("\xca\xd8\x95\xb3\xc2\xe8o'\xebd\xed\xbd'\xe6\xafu\x9bbl\xde6\xdaisg");

        if(!isDefined(ent)) {
          return;
        }

        if(self.state == "[\xb7\xecZ\xb9\x9d") {
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

function function_b40b3545d6777392(ent) {
  if(!isent(ent)) {
    return;
  }

  if(isarray(self)) {
    foreach(elevator in self) {
      elevator thread function_b40b3545d6777392(ent);
    }

    return;
  }

  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  ent endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    if(isDefined(ent)) {
      if(isDefined(self.floors[self.currentfloor].trigger)) {
        self waittill("\x82\x8dP\x9a\x15\x19\x85\x94':\xfc[\xac\xb9\f\x0eB%\x9c@wK");

        if(!isDefined(ent)) {
          return;
        }

        if(ispointinvolume(ent.origin, self.floors[self.currentfloor].trigger)) {
          self.floors[self.currentfloor].playerblocked = 1;
          self.floors[self.currentfloor] notify("\n\x18(\x97\xefy\xa1R\xbah\xe3\x9b\xffB");
          self.floors[self.currentfloor] thread function_9d3743c007076343();
          wait 0.5;

          while(self.floors[self.currentfloor].playerblocked == 1) {
            if(!isDefined(ent)) {
              return;
            }

            if(ispointinvolume(ent.origin, self.floors[self.currentfloor].trigger)) {
              self.floors[self.currentfloor].playerblocked = 1;
              self.floors[self.currentfloor] notify("\n\x18(\x97\xefy\xa1R\xbah\xe3\x9b\xffB");
              self.floors[self.currentfloor] thread function_9d3743c007076343();
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

  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  ent endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    if(isDefined(ent)) {
      if(isDefined(self.floors[self.currentfloor].trigger)) {
        self waittill("\xca\xd8\x95\xb3\xc2\xe8o'\xebd\xed\xbd'\xe6\xafu\x9bbl\xde6\xdaisg");

        if(!isDefined(ent)) {
          return;
        }

        if(self.state == "[\xb7\xecZ\xb9\x9d") {
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
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");

  while(true) {
    self.trigger waittill("\x91`\xb1\xe7T\x97>", enttriggered);

    if(istrue(self.elevator.car.var_a14873faa8c394d9)) {
      childthread elevatoroccupancytracking(enttriggered, self.elevator.car);
    }

    if(isPlayer(enttriggered) || isDefined(enttriggered.helperdronetype) || enttriggered vehicle::is_vehicle()) {
      self.playerblocked = 1;
      self notify("\n\x18(\x97\xefy\xa1R\xbah\xe3\x9b\xffB");
      thread function_9d3743c007076343();
    }

    waitframe();
  }
}

function function_9d3743c007076343() {
  self endon("\n\x18(\x97\xefy\xa1R\xbah\xe3\x9b\xffB");
  wait 0.7;

  if(isDefined(self)) {
    self.playerblocked = 0;
    self notify("\xd8t\xdb\x8fHnLw\x9a\xff\xf7D\nV\xb6\x13");
  }
}

function function_b9e7952fb498c0c6() {
  wait 1;
  thread function_8ce5c27c296f6365();
}

function elevatorextbuttonPressed(instance, part, state, player, bautouse, usestring) {
  if(isDefined(instance.floornum)) {
    if(instance.elevator.currentfloor == instance.floornum) {
      instance.elevator.state = "\xf5\xd9m\xd3x\xe1\x8b\xec\xb8\x0f";
    } else {
      instance.elevator.targetfloor = instance.floornum;
    }

    instance.elevator notify("\xd5L\xba\n\x10\xfd\xa2\xb8\x03\x12<n");
    instance.elevator.car.lastplayerused = player;
    instance.elevator.floors[instance.elevator.targetfloor] setscriptablepartstate("\xc0\xc6\xd4\xfd\x80\xe4\x151\xe4'\xac\xc4u\x82).$\xc9\x05", "\xd23\x8e5\x83\xe4\xc5X");

    if(instance.elevator.currentfloor > instance.elevator.targetfloor) {
      instance.elevator.floors[instance.elevator.targetfloor] setscriptablepartstate("\xdc\xdb\x9c5\x9f\xd2\xc8\xd8}0v\xb0y\x9a\xc9\x9d\xfb\xff\x1fQ\xb1U", "\xf3\xf2");
      return;
    }

    instance.elevator.floors[instance.elevator.targetfloor] setscriptablepartstate("\xdc\xdb\x9c5\x9f\xd2\xc8\xd8}0v\xb0y\x9a\xc9\x9d\xfb\xff\x1fQ\xb1U", "\x7f5\xe8e");
  }
}

function function_fc79ea5198fe17ff(instance, part, state, player, bautouse, usestring) {
  if(isDefined(player)) {
    player playSound("z\xbc\xcf\xf6\xe0\xfap\x84t\xde\x91\xc63f\xd1\x96\xd3c(\xff$\xb2\xadn");
  }

  if(isDefined(instance.elevator)) {
    elevator = instance.elevator;
  } else {
    elevator = instance.entity.elevator;
  }

  elevator.car.lastplayerused = player;
  elevator.targetfloor = elevator.currentfloor == 0 ? 1 : 0;
  elevator notify("\xd5L\xba\n\x10\xfd\xa2\xb8\x03\x12<n");
}

function function_c9d5afb253fb9caf() {
  foreach(part in self.parts) {
    if(isDefined(part.info)) {
      part.owner = self;
      self.floors[part.floornum] = part;
    }
  }
}

function elevatorbuttonPressed(instance, part, state, player, bautouse, usestring) {
  if(isDefined(instance.floornum)) {
    instance.elevator.car.lastplayerused = player;

    if(instance.floornum == 0) {
      instance.owner.targetfloor = instance.owner.currentfloor == 1 ? 2 : 1;
    } else if(instance.owner.currentfloor == instance.floornum) {
      instance.owner.state = "\xf5\xd9m\xd3x\xe1\x8b\xec\xb8\x0f";
    } else {
      instance.owner.targetfloor = instance.floornum;
    }

    instance.owner notify("\xd5L\xba\n\x10\xfd\xa2\xb8\x03\x12<n");
  }
}

function elevatordooropen(immediate) {
  self.open = 1;

  foreach(door in self.doors) {
    door.open = 1;

    if(!istrue(immediate)) {
      door setscriptablepartstate("\xe2\xc0Qo", "o\x1ce\xb9", 0);
    }
  }

  if(isDefined(self.indicator)) {
    self.indicator setscriptablepartstate("\xff\xb2\x0e\xc5\xc8", "X\x93\xc9i;\xac\x8c");
  }
}

function elevatordoorclose(immediate) {
  self.elevator endon("\vnRN\nj\xd8\xa1\xf6\x93\xdd]sr0");
  self.open = 0;

  foreach(door in self.doors) {
    door.open = 0;

    if(!istrue(immediate)) {
      door setscriptablepartstate("\xe2\xc0Qo", "\xdd}S\xf2<\xe9", 0);
    }
  }
}

function function_8ce5c27c296f6365() {
  while(true) {
    self[[level.elevatorsfuncs[self.state]]]();
  }
}

function function_3aca965d4b58f74e() {
  if(self.targetfloor != self.currentfloor) {
    if(self.floors[self.currentfloor].open) {
      self.state = "ax\xb6I\xb1\xae\x8a\x12\x91\xa6\x18\xda\x99";
    } else {
      self.state = "[\xb7\xecZ\xb9\x9d";
    }

    return;
  }

  self waittill("\xd5L\xba\n\x10\xfd\xa2\xb8\x03\x12<n");
}

function function_fe3561f50d2764ac() {
  if(istrue(self.var_aab55c602d9ed7ad)) {
    self waittill("\x18\xdf)\xcaC\x84\xcf\x1c;\x13\xf7qm");
  }

  self.floors[self.currentfloor] setscriptablepartstate("\xc0\xc6\xd4\xfd\x80\xe4\x151\xe4'\xac\xc4u\x82).$\xc9\x05", "\xd23\x8e5\x83\xe4\xc5X");
  self.floors[self.currentfloor] setscriptablepartstate("\xdc\xdb\x9c5\x9f\xd2\xc8\xd8}0v\xb0y\x9a\xc9\x9d\xfb\xff\x1fQ\xb1U", "\xf8\x88m");
  self notify("\xca\xd8\x95\xb3\xc2\xe8o'\xebd\xed\xbd'\xe6\xafu\x9bbl\xde6\xdaisg");
  isplatform = self.car.var_359253bfe053c819 == "k\xf0S{\x13\x16\x99\xdb";
  self.floors[self.currentfloor] thread elevatordooropen(isplatform);

  if(!isplatform) {
    if(self.car.var_42e3c04591ee0b10 && self.currentfloor != 0) {
      self.car thread animation::anim_single_solo(self.car, "IV\xb5\x84\x13\xaf\xf0\xd0\xf9");
    } else {
      self.car thread animation::anim_single_solo(self.car, "o\x1ce\xb9");
    }

    wait 5;
  }

  self.state = "\xc3\x969$\xc1\xd6\xfd";
}

function function_9cfadb56378e381d() {
  self endon("\vnRN\nj\xd8\xa1\xf6\x93\xdd]sr0");
  self notify("\x82\x8dP\x9a\x15\x19\x85\x94':\xfc[\xac\xb9\f\x0eB%\x9c@wK");
  wait 0.01;

  if(self.floors[self.currentfloor].playerblocked == 1) {
    thread function_d3df0e0109d2dd07();
    self.floors[self.currentfloor] waittill("\xd8t\xdb\x8fHnLw\x9a\xff\xf7D\nV\xb6\x13");
  }

  self notify("\xca\xd8\x95\xb3\xc2\xe8o'\xebd\xed\xbd'\xe6\xafu\x9bbl\xde6\xdaisg");
  thread function_acae46a49a9f502e();
  wait 0.01;
  isplatform = self.car.var_359253bfe053c819 == "k\xf0S{\x13\x16\x99\xdb";
  self.floors[self.currentfloor] thread elevatordoorclose(isplatform);

  if(!isplatform) {
    if(self.car.var_42e3c04591ee0b10 && self.currentfloor != 0) {
      str_anim = "\xaf\xf1\xe7\x9fp\x06l\xf0d?";
    } else {
      str_anim = "sh\xbc\ru";
    }

    self.car thread animation::anim_single_solo(self.car, str_anim);
    var_6ec6e35a8cb2fd89 = getanimlength(level.scr_anim[self.car.animname][str_anim]);
    self.car utility::waittill_notify_or_timeout(str_anim, var_6ec6e35a8cb2fd89);
    waitframe();
    waitframe();
  }

  self notify("\xd2\xa5\xc9+\xdd\x1ak\xabQ\xf5\xc4e\x98\x01{o3\xee\xbb");
  self notify("\xc0]\xd1\x14RY\x80-D\x98Zu\x96\xd1\r");
  self.state = "\xc3\x969$\xc1\xd6\xfd";

  if(!istrue(self.skip_interacts)) {
    self.floors[self.currentfloor] setscriptablepartstate("\xc0\xc6\xd4\xfd\x80\xe4\x151\xe4'\xac\xc4u\x82).$\xc9\x05", "\xba\x1bvTZH");
  }
}

function fsm_elevatormove() {
  for(i = 0; i < self.floors.size; i++) {
    if(isDefined(self.floors[i].indicator)) {
      if(self.floors[i].floornum == self.targetfloor) {
        if(self.currentfloor > self.targetfloor) {
          self.floors[i].indicator setscriptablepartstate("\xff\xb2\x0e\xc5\xc8", "\x7f5\xe8e");
        } else {
          self.floors[i].indicator setscriptablepartstate("\xff\xb2\x0e\xc5\xc8", "\xf3\xf2");
        }

        continue;
      }

      if(self.floors[i].floornum > self.targetfloor) {
        self.floors[i].indicator setscriptablepartstate("\xff\xb2\x0e\xc5\xc8", "\x7f5\xe8e");
        continue;
      }

      self.floors[i].indicator setscriptablepartstate("\xff\xb2\x0e\xc5\xc8", "\xf3\xf2");
    }
  }

  totalheight = abs(self.floors[self.targetfloor].targetheight - self.floors[self.currentfloor].targetheight);
  totalaccelerationtime = self.car.var_2923c9a57f9987db + self.car.var_f9db675dc1879d40;

  if(isDefined(self.car.n_travel_time)) {
    assert(self.car.n_travel_time >= totalaccelerationtime, "<dev string:x94>" + totalaccelerationtime + "<dev string:xbe>");

    if(self.car.n_travel_time >= totalaccelerationtime) {
      duration = self.car.n_travel_time;
    }
  }

  if(isDefined(level.elevatormaxspeed)) {
    duration = max(totalheight / level.elevatormaxspeed, totalaccelerationtime + 0.25);
  } else if(!isDefined(duration)) {
    duration = max(totalheight / 150, totalaccelerationtime + 0.25);
  }

  foreach(ent in self.car.occupants) {
    if(isPlayer(ent) && isalive(ent)) {
      ent thread function_3082112da9554f42(duration);
    }
  }

  targetpos = (self.car.origin[0], self.car.origin[1], self.floors[self.targetfloor].targetheight);
  self.car.moving = self.currentfloor > self.targetfloor ? #"moving_down" : #"moving_up";
  self.car setscriptablepartstate("E,d~\xe2dkt]\x0f_\xf5Vg\xb0", "\xb8\"");

  if(isDefined(level.gametype) && level.gametype == "0\xbb\xac") {
    self.car.origin = targetpos;
    wait duration;
  } else {
    self.car moveTo(targetpos, duration, self.car.var_2923c9a57f9987db, self.car.var_f9db675dc1879d40);
    wait duration;
  }

  self.car setscriptablepartstate("E,d~\xe2dkt]\x0f_\xf5Vg\xb0", "\xf8\x88m");
  wait 0.5;
  self.car.moving = #"moving_stopped";
  self.currentfloor = self.targetfloor;
  self.state = "\xf5\xd9m\xd3x\xe1\x8b\xec\xb8\x0f";

  for(i = 0; i < self.floors.size; i++) {
    if(isDefined(self.floors[i].indicator)) {
      if(self.floors[i].floornum != self.currentfloor) {
        self.floors[i].indicator setscriptablepartstate("\xff\xb2\x0e\xc5\xc8", "\xf8\x88m");
      }
    }
  }
}

function function_3082112da9554f42(duration) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self allowprone(0);
  wait duration + 0.5;
  self allowprone(1);
}

function function_acae46a49a9f502e() {
  self endon("\xc0]\xd1\x14RY\x80-D\x98Zu\x96\xd1\r");
  self endon("\x82\x8dP\x9a\x15\x19\x85\x94':\xfc[\xac\xb9\f\x0eB%\x9c@wK");
  self endon("\xd2\xa5\xc9+\xdd\x1ak\xabQ\xf5\xc4e\x98\x01{o3\xee\xbb");

  while(true) {
    if(self.floors[self.currentfloor].playerblocked == 1) {
      self notify("\vnRN\nj\xd8\xa1\xf6\x93\xdd]sr0");
      self.state = "\xf5\xd9m\xd3x\xe1\x8b\xec\xb8\x0f";
      wait 0.025;
      self.state = "ax\xb6I\xb1\xae\x8a\x12\x91\xa6\x18\xda\x99";
      return;
    }

    waitframe();
  }
}

function function_676d28fdd78d01df(num) {
  return self.floors[num].child.child.child.origin;
}

function function_db611bc8a4297d81() {
  function_c83878168c0f4cfc("+\xd8eg\x16\x1d\xb7\xc9\xafb\xd5\xe8G\xde\xcd\xf5fc{o\x9c_\x03\xc4");
  function_c83878168c0f4cfc("\x8f\xaf\xa8\xb7\x97\xc5\xfe:\xe0.\xd9kB\xc2RN\xfd\xc6]\xec\x02?<v");
  function_c83878168c0f4cfc("\x8c\x97\x9fc\x95\xf7\xbb\xdaXX{\xe8\xc1GL\x1egz\x9bRE\xc3\xc0Q\xd4");
}

function function_c83878168c0f4cfc(str) {
  oldpart = self.parts[str];
  buttonpos = oldpart.origin;
  buttonangles = oldpart.angles + (90, 0, 0);
  button = spawnscriptable("\xc3#\xbf\xdaH\xb3^\xbbh+p\xbc\x9c\xa9l\r\x01\x9a\xf9\x15\n\x12", buttonpos, buttonangles);
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

#using_animtree("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6");

function script_model_anims(subtype) {
  level.scr_animtree["[\xa3y\x10lNz\xda"] = #animtree;
  level.scr_anim["[\xa3y\x10lNz\xda"]["sh\xbc\ru"] = % J\xf5\xe0\xe0e\x88, fj\xd9\x1f\xee`\xbd3\xcc\xef~.y\xcc\xf3q1\xc4\xd0';
level.scr_eventanim[ "[\xa3y\x10lNz\xda" ][ "sh\xbc\ru" ] = %"iw9_elevator_int_door_close";
level.scr_animtree[ "[\xa3y\x10lNz\xda" ] = #animtree;
level.scr_anim[ "[\xa3y\x10lNz\xda" ][ "o\x1ce\xb9" ] = %iwN\xf5\x95cV\xce\x16\xa3\xb7N\xf5\x967\x8e\xbe\x8c\xde\xed\xc9\xfa\xed\x0e\xca\x9b;
level.scr_eventanim[ "[\xa3y\x10lNz\xda" ][ "o\x1ce\xb9" ] = %"iw9_elevator_int_door_open";
level.scr_animtree[ "s>*\xadd\x87\xe7\xb7[\xe2)\x05[}_" ] = #animtree;
level.scr_anim[ "s>*\xadd\x87\xe7\xb7[\xe2)\x05[}_" ][ "sh\xbc\ru" ] = %a\xf2H\x1a\a\xf5D\xafKZ\xa0\x02\x82\xc7\xaf\x1e,]\xda\xab\xd9\xb1\xf3\xfa\xdb|\xe7\xc1U\xda9'\xe9,\\jD\xfb\xfcOk\xee\xc4X \xf6\xa1;
level.scr_eventanim[ "s>*\xadd\x87\xe7\xb7[\xe2)\x05[}_" ][ "sh\xbc\ru" ] = %"t10_ava_building_elevator_double_int_door_close";
level.scr_animtree[ "s>*\xadd\x87\xe7\xb7[\xe2)\x05[}_" ] = #animtree;
level.scr_anim[ "s>*\xadd\x87\xe7\xb7[\xe2)\x05[}_" ][ "o\x1ce\xb9" ] = %F\xd8\xabv\x11\x14\xaf}\x9c\x7fgG)E\x03\xe3,B\x1e\xbcX\xe7\x9a^\xf6\x8e\xbdF\xee\xc4\xc1\x17~\b\xc4\xe5\xa2\xa6\x0f\xc7\xf0\xaf\xde\xb8A\x01;
level.scr_eventanim[ "s>*\xadd\x87\xe7\xb7[\xe2)\x05[}_" ][ "o\x1ce\xb9" ] = %"t10_ava_building_elevator_double_int_door_open";
level.scr_animtree[ "s>*\xadd\x87\xe7\xb7[\xe2)\x05[}_" ] = #animtree;
level.scr_anim[ "s>*\xadd\x87\xe7\xb7[\xe2)\x05[}_" ][ "\xaf\xf1\xe7\x9fp\x06l\xf0d?" ] = %\x8e\x89\xc0\xafa;\x85}1\xba-\x1bd-n\xce\xf5\xb2l+\xcea\xe8\xde\x93\xfadoWLcV\xd7\xa57\xe8\xf5\x98\x166m\xafd\xdb\xb7r\xf5\x8d\x1b{ne;
level.scr_eventanim[ "s>*\xadd\x87\xe7\xb7[\xe2)\x05[}_" ][ "\xaf\xf1\xe7\x9fp\x06l\xf0d?" ] = %"t10_ava_building_elevator_double_int_back_door_close";
level.scr_animtree[ "s>*\xadd\x87\xe7\xb7[\xe2)\x05[}_" ] = #animtree;
level.scr_anim[ "s>*\xadd\x87\xe7\xb7[\xe2)\x05[}_" ][ "IV\xb5\x84\x13\xaf\xf0\xd0\xf9" ] = %\xf7I:\xe4\x81&)O||\xff;\b\xcexS\xdd\x89X\xd9l\xd7\xd8St\x86n\xe1\x05\xbe\xae+U\x9cN\xc8P\xde`\
  x9aPV\xdd\xcdp\xec\x03E\x18\xd1\x98;
  level.scr_eventanim["s>*\xadd\x87\xe7\xb7[\xe2)\x05[}_"]["IV\xb5\x84\x13\xaf\xf0\xd0\xf9"] = % "t10_ava_building_elevator_double_int_back_door_open";
  level.scr_animtree[" 4\xfcN\xd4\xeb\xd8\\Yi\xedS\xdaf"] = #animtree;
  level.scr_anim[" 4\xfcN\xd4\xeb\xd8\\Yi\xedS\xdaf"]["sh\xbc\ru"] = % \x88\x9c\x89G\xeb~#zc\xde &P\xe5\x94\xd0\x1a\\y\xecn. {
    \
    xad\xe1\xfe\x82\x9d]\x81\b\x82\xa8\xc9\x01 / \xdc > b ^ \x1f9[\xcd\xf8og\xcbE\x17\nSU\xce\xd5\xb0 = ; level.scr_eventanim[" 4\xfcN\xd4\xeb\xd8\\Yi\xedS\xdaf"]["sh\xbc\ru"] = % "t10_machinery_elevator_passenger_small_single_door_close"; level.scr_animtree[" 4\xfcN\xd4\xeb\xd8\\Yi\xedS\xdaf"] = #animtree; level.scr_anim[" 4\xfcN\xd4\xeb\xd8\\Yi\xedS\xdaf"]["o\x1ce\xb9"] = % \x8eb\f_\xad\vc\xa1 - \x9b\xca\xc9\xf2\xbe\xac\x8d\xb2;\v\xa3\xb7N\xaf8, \xe6\xcdY\xcdv\xb2\x9c\xf5\xb9\xb5\xc26\xb1
  }\
  x9b\xb4\xdc\xeccY\xf5d\xbd\xedN\xfa {
    \
    x83e\xdc;
    level.scr_eventanim[" 4\xfcN\xd4\xeb\xd8\\Yi\xedS\xdaf"]["o\x1ce\xb9"] = % "t10_machinery_elevator_passenger_small_single_door_open";
    level.scr_animtree["\x01x\x8a\xe3\xf2\f\xf5\x84\xf76\xae\xd8\x0ee.m\x9d\xae~-\x1e"] = #animtree;
    level.scr_anim["\x01x\x8a\xe3\xf2\f\xf5\x84\xf76\xae\xd8\x0ee.m\x9d\xae~-\x1e"]["sh\xbc\ru"] = % \x03\xbe\x95\xee\xc0\xae\xdd
  }\
  xd4\xe9o\x96\xf19 = \x85\x81\xcec\xd2xc ? \xef\xf5 {
    \
    xf7\x91\v
  }
  X\x04 % \xf0\xd4\xdf\r\x99\xef\xfe @\xaa\xe1 | k #\xd5P\xd5 - \xa7\xb6\xf8\xe4C\xe4T ? \x1e\x8c;
  level.scr_eventanim["\x01x\x8a\xe3\xf2\f\xf5\x84\xf76\xae\xd8\x0ee.m\x9d\xae~-\x1e"]["sh\xbc\ru"] = % "t10_machinery_elevator_passenger_small_double_door_frnt_close";
  level.scr_animtree["\x01x\x8a\xe3\xf2\f\xf5\x84\xf76\xae\xd8\x0ee.m\x9d\xae~-\x1e"] = #animtree;
  level.scr_anim["\x01x\x8a\xe3\xf2\f\xf5\x84\xf76\xae\xd8\x0ee.m\x9d\xae~-\x1e"]["o\x1ce\xb9"] = % \x0f\xe4\x05\xf3 % \xdf, \x0e2\xe8\x1d\xf7\x0e\xf2\x17R\xb4\xc0\x18\xd1\x01\xfa\xcf\xfd > ? \xec\xe9\xdc\xf1\xba\xfb\xa3\xea\xde\x89\xca\xf7t\\\x83\xbfaX\xb2Ji\xef_F;\
  x8e\xd3\xf2\xbdw\x02N\xe7\xa0;
  level.scr_eventanim["\x01x\x8a\xe3\xf2\f\xf5\x84\xf76\xae\xd8\x0ee.m\x9d\xae~-\x1e"]["o\x1ce\xb9"] = % "t10_machinery_elevator_passenger_small_double_door_frnt_open";
  level.scr_animtree["\x01x\x8a\xe3\xf2\f\xf5\x84\xf76\xae\xd8\x0ee.m\x9d\xae~-\x1e"] = #animtree;
  level.scr_anim["\x01x\x8a\xe3\xf2\f\xf5\x84\xf76\xae\xd8\x0ee.m\x9d\xae~-\x1e"]["\xaf\xf1\xe7\x9fp\x06l\xf0d?"] = % M\xbd\xf9\xc5\xbb\x18\xa5k\xf0\x90JtW3 ? \xb0\x8f\xcab\fZ\x0fe\xed3 k\xa4[VlB\x7f\xb9\xd8N\xeb_\xb9 {
        \
        xd7R\x85\xeaT\x82i\x81\x8b\xf8\xc2$ > \x98 @\x1d\xe1M\x97Z\xcf;
        level.scr_eventanim["\x01x\x8a\xe3\xf2\f\xf5\x84\xf76\xae\xd8\x0ee.m\x9d\xae~-\x1e"]["\xaf\xf1\xe7\x9fp\x06l\xf0d?"] = % "t10_machinery_elevator_passenger_small_double_door_rear_close";
        level.scr_animtree["\x01x\x8a\xe3\xf2\f\xf5\x84\xf76\xae\xd8\x0ee.m\x9d\xae~-\x1e"] = #animtree;
        level.scr_anim["\x01x\x8a\xe3\xf2\f\xf5\x84\xf76\xae\xd8\x0ee.m\x9d\xae~-\x1e"]["IV\xb5\x84\x13\xaf\xf0\xd0\xf9"] = % \x89;
        S\x88\xb0\xa3\xf7\tt\xb0\x81\xe4V\xd78\xd8x\f\xd1\xc2 * 60\x18k5\xb2(JO\xc5\x96\x98\x1a\xc4\xc0\x88, \x12\xe6\xff\xce\xe0\x88\x8d\xc7Jy\xaeu < \xb2\xaa\x031 '\x96\x90$G;
          level.scr_eventanim["\x01x\x8a\xe3\xf2\f\xf5\x84\xf76\xae\xd8\x0ee.m\x9d\xae~-\x1e"]["IV\xb5\x84\x13\xaf\xf0\xd0\xf9"] = % "t10_machinery_elevator_passenger_small_double_door_rear_open";
        }

        function elevatoroccupancytracking(enttriggered, car) {
          enttriggered notify("{\x17\x83\x03\xefq\x19\x04\xbb\xcf\x15B\v\x0e\xfa\xdf\xaf\xa6\xaa\xcf}\xa9%jMf\xac");
          enttriggered endon("{\x17\x83\x03\xefq\x19\x04\xbb\xcf\x15B\v\x0e\xfa\xdf\xaf\xa6\xaa\xcf}\xa9%jMf\xac");
          enttriggered endon("\x1e\xfd\xd1\xa2\a");
          enttriggered endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
          short_interval = 0.1;
          long_interval = 1.5;
          var_17048dedc8c1fe6b = long_interval;
          var_73e8831dfb12ecbe = 140;

          while(isDefined(enttriggered)) {
            car function_7bf1614bccf28e6b(enttriggered, 1);

            while(!enttriggered isinsideelevator(car)) {
              wait short_interval;
              var_17048dedc8c1fe6b -= short_interval;

              if(var_17048dedc8c1fe6b < 0) {
                var_17048dedc8c1fe6b = long_interval;

                if(utility::distance_2d_squared(enttriggered.origin, car.origin) > var_73e8831dfb12ecbe * var_73e8831dfb12ecbe) {
                  return;
                }
              }
            }

            car function_7bf1614bccf28e6b(enttriggered);

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

            car = utility::getclosest(self.origin, elevatorcars);

            if(!isDefined(car)) {
              return 0;
            }
          }

          if(!istrue(car.var_a14873faa8c394d9)) {
            return 0;
          }

          if(getdvarint(@ "hash_24b1d20863cdd66a", 0) == 1) {
            if(isDefined(car.occupancytrig) && ispointinvolume(self.origin, car.occupancytrig)) {
              if(!istrue(self.isinsideelevator)) {
                car function_7bf1614bccf28e6b(self);
              }

              return 1;
            }

            if(isDefined(car.corner_a)) {
              z_padding = 16;

              if(self.origin[2] < car.origin[2] - z_padding && self.origin[2] > car.origin[2] + car.carheight + z_padding) {
                return 0;
              }

              if(function_cf254474b0e6b72b(self.origin, car.corner_a, car.corner_b, car.corner_c, car.corner_d)) {
                if(!istrue(self.isinsideelevator)) {
                  car function_7bf1614bccf28e6b(self);
                }

                return 1;
              }
            }

            return 0;
          }

          if(isDefined(car.occupancytrig) && !ispointinvolume(self.origin, car.occupancytrig)) {
            return 0;
          }

          if(isDefined(car.corner_a) && !function_cf254474b0e6b72b(self.origin, car.corner_a, car.corner_b, car.corner_c, car.corner_d)) {
            return 0;
          }

          zpadding = 16;
          var_3a73d4992e2aec3e = car.elevator.floors[0].targetheight - zpadding;
          var_21c451eff905ae40 = car.elevator.floors[1].targetheight + car.carheight + 5;

          if(self.origin[2] <= car.origin[2] - zpadding || self.origin[2] >= car.origin[2] + car.carheight) {
            if(self.origin[2] >= var_3a73d4992e2aec3e && self.origin[2] <= var_21c451eff905ae40) {
              glitchedorigin = self.origin;
              teleporttoorigin = (self.origin[0], self.origin[1], car.origin[2]);
              teleporttoorigin = vectorlerp(car.origin, teleporttoorigin, 0.85) + (0, 0, zpadding);

              if(isDefined(car.occupancytrig) && !ispointinvolume(self.origin, car.occupancytrig) || isDefined(car.corner_a) && !function_cf254474b0e6b72b(self.origin, car.corner_a, car.corner_b, car.corner_c, car.corner_d)) {
                teleporttoorigin = car.origin + (randomintrange(-48, 48), randomintrange(-48, 48), zpadding);
              }

              print3d(glitchedorigin, "<dev string:xc4>", (1, 0.25, 0), 1, 0.25, 1000);
              line(glitchedorigin + (-4, -4, 0), glitchedorigin + (4, 4, 0), (1, 0.25, 0), 1, 0, 1000);
              line(glitchedorigin + (-4, 4, 0), glitchedorigin + (4, -4, 0), (1, 0.25, 0), 1, 0, 1000);
              line(teleporttoorigin, glitchedorigin, (1, 1, 0), 1, 0, 1000);
              line(teleporttoorigin + (-4, -4, 0), teleporttoorigin + (4, 4, 0), (0, 1, 1), 1, 0, 1000);
              line(teleporttoorigin + (-4, 4, 0), teleporttoorigin + (4, -4, 0), (0, 1, 1), 1, 0, 1000);
              print3d(teleporttoorigin, "<dev string:xd0>", (0, 1, 1), 1, 0.25, 1000);

              self setOrigin(teleporttoorigin);
              return 1;
            }

            return 0;
          }

          if(!istrue(self.isinsideelevator)) {
            car function_7bf1614bccf28e6b(self);
          }

          return 1;
        }

        function function_7bf1614bccf28e6b(occupant, remove_occupant) {
          self.occupants = utility::function_9b645290bcb05f87(self.occupants);

          if(!isDefined(occupant)) {
            return;
          }

          if(istrue(remove_occupant)) {
            occupant.isinsideelevator = 0;
            occupant.var_a45c55a61d30d4b = undefined;
            self.occupants = arrayremove(self.occupants, occupant);
            return;
          }

          thread removeoccupantondeath(occupant);
          occupant.isinsideelevator = 1;
          occupant.var_a45c55a61d30d4b = self;

          if(!arraycontains(self.occupants, occupant)) {
            self.occupants[self.occupants.size] = occupant;
          }
        }

        function removeoccupantondeath(occupant) {
          occupant notify("\xc3FEH\xdc\x8fk\x1f_\xf7\v\xd7\xc1i{\xd1\xdc~\xe3\xccS");
          occupant endon("\xc3FEH\xdc\x8fk\x1f_\xf7\v\xd7\xc1i{\xd1\xdc~\xe3\xccS");
          occupant waittill("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

          if(isDefined(occupant)) {
            occupant.isinsideelevator = 0;
            occupant.var_a45c55a61d30d4b = undefined;
            self.occupants = arrayremove(self.occupants, occupant);
            return;
          }

          self.occupants = utility::array_removeundefined(self.occupants);
        }

        function function_cf254474b0e6b72b(point, corner_a, corner_b, corner_c, corner_d) {
          corner_a = (corner_a[0], corner_a[1], 0);
          corner_b = (corner_b[0], corner_b[1], 0);
          corner_c = (corner_c[0], corner_c[1], 0);
          corner_d = (corner_d[0], corner_d[1], 0);
          point = (point[0], point[1], 0);
          center = vectorlerp(corner_a, corner_c, 0.5);
          var_c9f71f23aff92e46 = pointonsegmentnearesttopoint(corner_a, corner_b, point);
          var_550d6b6e195f301e = pointonsegmentnearesttopoint(corner_b, corner_c, point);

          if(utility::distance_2d_squared(center, point) <= utility::distance_2d_squared(center, var_c9f71f23aff92e46) && utility::distance_2d_squared(center, point) <= utility::distance_2d_squared(center, var_550d6b6e195f301e)) {
            return true;
          }

          return false;
        }

        function function_d3df0e0109d2dd07() {
          level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
          self endon("\x82\x8dP\x9a\x15\x19\x85\x94':\xfc[\xac\xb9\f\x0eB%\x9c@wK");
          self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");

          while(self.floors[self.currentfloor].playerblocked == 1) {
            self.car playSound("[\xfdAX\xf1\xe8\xb5[\xc4\x0e\xf9UIs\x11\xa8");

            if(self.floors[self.currentfloor].playerblocked == 0) {
              break;
            }

            wait 3;
          }
        }

        function function_3e1f2fc4b004e197(callbackfunction) {
          self.elevatordoorsclosecallback = callbackfunction;
        }