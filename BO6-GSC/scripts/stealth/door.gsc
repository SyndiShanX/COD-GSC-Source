/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\stealth\door.gsc
**************************************/

#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\stealth\enemy;
#using scripts\stealth\utility;
#namespace door;

function stealth_suspicious_doors_init() {
  if(istrue(level.ship_assault)) {
    return;
  }

  if(isDefined(level.stealth)) {
    if(!isDefined(level.stealth.suspicious_door)) {
      level.stealth.suspicious_door = spawnStruct();
      level.stealth.suspicious_door.doors = [];
      level.stealth.suspicious_door.reset_time = 30;
      level.stealth.suspicious_door.sight_distsqrd = squared(600);
      level.stealth.suspicious_door.detect_distsqrd = squared(200);
      level.stealth.suspicious_door.found_distsqrd = squared(128);
    }

    level utility::set_stealth_func("\x9bE\xf4Xw5\xc9\x04TRQk\xa8\x87\x7f", &suspicious_door_found);
  }
}

function suspicious_door_thread() {
  self notify("7\xba7\x0e\xa5\x1b\xd2\xdbu\xcd\xf52{\xb7\xc9_\x8e4r+\xc2\x91");
  self endon("7\xba7\x0e\xa5\x1b\xd2\xdbu\xcd\xf52{\xb7\xc9_\x8e4r+\xc2\x91");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x88U\x9a\xd2\xc7\x14Z<\xd5p");

  while(true) {
    utility::ent_flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");

    if(!utility::function_4c52c2d0a7b596cf()) {
      suspicious_door_sighting();
    }

    wait 0.1;
  }
}

function suspicious_door_sighting() {
  if(!isDefined(self.stealth.suspicious_door)) {
    self.stealth.suspicious_door = spawnStruct();
  }

  if(isDefined(self.stealth.suspicious_door.nexttime) && gettime() < self.stealth.suspicious_door.nexttime) {
    return;
  }

  if(self.ignoreall) {
    return;
  }

  if(istrue(self.var_2ed1e571f0431638)) {
    return;
  }

  if(istrue(self.stealth.suspicious_door.investigating)) {
    return;
  }

  if(isDefined(self.stealth.suspicious_door.ent)) {
    debounce = 100;
  } else {
    debounce = 1000;
  }

  self.stealth.suspicious_door.nexttime = gettime() + debounce;
  doors = level.stealth.suspicious_door.doors;
  found_door = undefined;
  saw_door = undefined;
  door = undefined;

  foreach(door in doors) {
    doorentnum = door getentitynumber();

    if(isDefined(door.found)) {
      continue;
    }

    doororigin = door.origin;
    distsq = distancesquared(self.origin, doororigin);
    var_e8164f5e0ecb6f94 = level.stealth.suspicious_door.found_distsqrd;
    var_944f52cc7f6a3c79 = level.stealth.suspicious_door.sight_distsqrd;
    var_f6f00e640098215d = level.stealth.suspicious_door.detect_distsqrd;

    if(doororigin[2] - self.origin[2] > 128) {
      continue;
    }

    if(isDefined(self.stealth.suspicious_door.ent)) {
      if(self.stealth.suspicious_door.ent == door) {
        continue;
      }

      doororiginnew = self.stealth.suspicious_door.ent.origin;
      dist2sq = distancesquared(self.origin, doororiginnew);

      if(dist2sq <= distsq) {
        continue;
      }
    }

    if(distsq < var_e8164f5e0ecb6f94) {
      if(abs(self.origin[2] - doororigin[2]) < 60) {
        if(getdvarint(@ "debug_stealth_doors")) {
          line(doororigin, self.origin, (0, 1, 0), 1, 0, 400);
        }

        found_door = door;
        break;
      }
    }

    if(distsq > var_944f52cc7f6a3c79) {
      continue;
    }

    if(distsq < var_f6f00e640098215d) {
      if(canseedoor(door, debounce)) {
        found_door = door;
        break;
      }
    }

    sight = anglesToForward(self gettagangles("\xc7\xae?f\x10\xbcr"));
    var_d95728a93c5340a9 = vectorNormalize(doororigin + (0, 0, 30) - self getEye());

    if(vectordot(sight, var_d95728a93c5340a9) > 0.55) {
      if(canseedoor(door, debounce)) {
        found_door = door;
        break;
      }
    }
  }

  if(isDefined(found_door)) {
    found_door.found = 1;
    spot = undefined;

    if(isDefined(door.cam_structs)) {
      spot = door.cam_structs[0].origin;
    } else {
      spot = door.origin;
    }

    self aieventlistenerevent("\x9bE\xf4Xw5\xc9\x04TRQk\xa8\x87\x7f", found_door, spot);
  }
}

function private canseedoor(door, debounce) {
  result = 0;
  debugorigin = door.origin;

  if(!isDefined(door.seen)) {
    if(self cansee(door, debounce)) {
      result = 1;
    } else {
      handleoffset = rotatevectorinverted(door.open_struct.origin - door.origin, door.true_start_angles);
      handleorigin = door.origin + rotatevector(handleoffset, door.pivot_ent.angles);
      ignoreents = utility::array_add(function_a67d81ca66a25657(), door);

      if(isDefined(door.clip)) {
        ignoreents[ignoreents.size] = door.clip;
      }

      if(isDefined(door.clip_nosight)) {
        ignoreents[ignoreents.size] = door.clip_nosight;
      }

      startorigin = self getEye();
      originstocheck = [door.origin, handleorigin];

      foreach(origin in originstocheck) {
        debugorigin = origin;
        trace = trace::ray_trace(startorigin, origin, ignoreents);

        if(trace[")\x9a\x94]\xee}s"] == "\x90\x17\x030\x83m\x0f}D\x02f\xd9") {
          result = 1;
          break;
        }
      }
    }
  }

  if(getdvarint(@ "debug_stealth_doors")) {
    color = result ? (0, 1, 0) : (1, 0, 0);
    frames = int(debounce / 1000 * 20);
    print3d(debugorigin, door getentitynumber(), (1, 1, 1), 1, 1, frames);
    line(debugorigin, self.origin, color, 1, 0, frames);
  }

  return result;
}

function suspicious_door_found(event) {
  door = event.entity;

  if(isDefined(door.aiopener)) {
    return;
  }

  door.aiopener = self;

  if(isDefined(door.cam_structs) && isDefined(door.cam_structs[0])) {
    spot = door.cam_structs[0].origin;
  } else {
    spot = door.origin;
  }

  point = getclosestpointonnavmesh(spot, self);
  distscalar = 75;
  doorright = anglestoright(door.true_start_angles);
  doornormal = vectorNormalize(self.origin - door.origin);

  if(vectordot(doorright, doornormal) > 0) {
    distscalar *= -1;
  }

  event.origin = spot + doorright * distscalar;
  event.investigate_pos = getclosestpointonnavmesh(event.origin, self);

  if(getdvarint(@ "debug_stealth_doors")) {
    line(door.origin, door.origin + doorright * 10, (1, 0, 0), 1, 0, 400);
    line(door.origin, event.origin, (1, 1, 0), 1, 0, 400);
    line(door.origin, event.investigate_pos, (0, 1, 0), 1, 0, 400);
  }

  if(self.stealth_bsmstate < 2) {
    enemy::bt_set_stealth_state("\xc2\x99.K\xdd\x9fBw>]\x8e", event);
  }
}