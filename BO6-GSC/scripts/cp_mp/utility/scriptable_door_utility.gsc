/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\scriptable_door_utility.gsc
*************************************************************/

#using scripts\common\system;
#using scripts\engine\utility;
#namespace scriptable_door_utility;

function private autoexec __init__system__() {
  system::register(#"scriptable_door_utility", undefined, undefined, &post_main);
}

function private post_main() {
  if(isofflinetoolrun(63)) {
    return;
  }

  init_post_funcs();
  function_348426697254d2e5();
}

function private init_post_funcs() {
  level.var_598f3043421fe530 = [];
  level.var_598f3043421fe530["door_trigger"] = &door_trigger;
}

function private function_348426697254d2e5() {
  foreach(targetname, func in level.var_598f3043421fe530) {
    if(isDefined(func)) {
      entlist = getEntArray(targetname, "targetname");

      foreach(entity in entlist) {
        entity thread[[func]]();
      }
    }
  }
}

function scriptable_door_get_in_radius(position, radius, maxheightdiff) {
  doors = getentitylessscriptablearray(undefined, undefined, position, radius, "door");
  filtereddoors = [];

  foreach(door in doors) {
    if(!door scriptableisdoor()) {
      continue;
    }

    if(isDefined(maxheightdiff)) {
      heightdiff = door.origin[2] - position[2];

      if(heightdiff <= maxheightdiff) {
        filtereddoors[filtereddoors.size] = door;
      }

      continue;
    }

    filtereddoors[filtereddoors.size] = door;
  }

  return filtereddoors;
}

function scriptable_door_freeze_open(isbashleft) {
  self notify("scriptable_door_freeze_open");
  self endon("scriptable_door_freeze_open");
  bashstate = undefined;
  targetangles = undefined;

  if(isbashleft) {
    bashstate = "bash_left_90";
    targetangles = self function_9ae4daa2a11c58bd() + (0, 90, 0);
  } else {
    bashstate = "bash_right_90";
    targetangles = self function_9ae4daa2a11c58bd() + (0, -90, 0);
  }

  while(anglesdelta(self.angles, targetangles) > 1) {
    currentstate = self getscriptablepartstate("door");

    if(currentstate != bashstate) {
      self setscriptablepartstate("door", bashstate, 0);
    }

    wait 0.05;
  }

  self setscriptablepartstate("door", "ajar", 0);
  self scriptabledoorfreeze(1);
}

function function_a6d402d10d7a3a2e(doors) {
  foreach(door in doors) {
    door scriptabledoorfreeze();
  }
}

function scriptable_door_is_double_door_pair(otherdoor) {
  if(self == otherdoor) {
    return false;
  }

  centera = self function_50ddcb729a6c2820();
  centerb = otherdoor function_50ddcb729a6c2820();
  distsqrd = distancesquared(centera, centerb);

  if(distsqrd > 961 || distsqrd < 441) {
    return false;
  }

  return true;
}

function function_c4446a4597ae7ab2(otherdoor) {
  if(self == otherdoor) {
    return false;
  }

  centera = self function_50ddcb729a6c2820();
  centerb = otherdoor function_50ddcb729a6c2820();
  centerdistsqrd = distancesquared(centera, centerb);

  if(centerdistsqrd > 3249 || centerdistsqrd < 2209) {
    return false;
  }

  hingea = self.origin;
  hingeb = otherdoor.origin;
  hingedistsqrd = distancesquared(hingea, hingeb);

  if(hingedistsqrd > 11881 || hingedistsqrd < 9801) {
    return false;
  }

  return true;
}

function private function_f5b4bddd853e6304() {
  if(!isDefined(self.script_parameters)) {
    return [];
  }

  parmlist = strtok(self.script_parameters, ";");
  parmsresult = [];

  foreach(parm in parmlist) {
    var_3cab52442d84430 = strtok(parm, " =");

    if(isDefined(var_3cab52442d84430[1])) {
      parmsresult[var_3cab52442d84430[0]] = var_3cab52442d84430[1];
      continue;
    }

    parmsresult[var_3cab52442d84430[0]] = 1;
  }

  return parmsresult;
}

function function_9e6f32944120e733(createnavobstacle = 1) {
  self endon("death");
  function_1864b7fc259dd0fb();
  self.var_1a797c53e833daea = 1;
  utility::flag_wait("scriptables_ready");
  locks = getentitylessscriptablearray(self.target, "targetname", undefined, undefined, "door_lock");

  foreach(lock in locks) {
    lock setscriptablepartstate("door_lock", "locked", 0);
  }

  if(createnavobstacle) {
    self.navobstacles = [];
    doorlist = getentitylessscriptablearray(self.target, "targetname", undefined, undefined, "door");

    foreach(door in doorlist) {
      if(isDefined(door.model)) {
        halfbounds = function_decb653c5689e4ca(door.model);
        localmid = function_caaf4dc13b656242(door.model);
        mid = coordtransform(localmid, door.origin, door.angles);
        self.navobstacles[self.navobstacles.size] = createnavobstaclebybounds(mid, halfbounds, door.angles);
      }
    }
  }
}

function simple_unlock_door() {
  self endon("death");
  utility::flag_wait("scriptables_ready");
  self.var_1a797c53e833daea = undefined;
  locks = getentitylessscriptablearray(self.target, "targetname", undefined, undefined, "door_lock");

  foreach(lock in locks) {
    lock setscriptablepartstate("door_lock", "static", 0);
  }

  function_1864b7fc259dd0fb();
}

function function_1864b7fc259dd0fb() {
  if(isarray(self.navobstacles)) {
    foreach(obstacle in self.navobstacles) {
      destroynavobstacle(obstacle);
    }

    self.navobstacles = undefined;
  }
}

function function_ebbc2714ba8e6bd9(state) {
  assert(isstring(state), "<dev string:x24>");
  doorlist = getentitylessscriptablearray(self.target, "targetname", undefined, undefined, "door");

  foreach(door in doorlist) {
    door setscriptablepartstate("door", state, 0);
  }
}

function private door_trigger() {
  self endon("death_or_disconnect");

  if(!isDefined(self.target)) {
    return;
  }

  parms = function_f5b4bddd853e6304();

  if(parms["locked"]) {
    thread function_9e6f32944120e733();
  }

  while(true) {
    self waittill("trigger");

    if(self.var_1a797c53e833daea) {
      continue;
    }

    doorlist = getentitylessscriptablearray(self.target, "targetname", undefined, undefined, "door");

    foreach(door in doorlist) {
      if(isstring(parms["state"])) {
        door setscriptablepartstate("door", parms["state"], 0);
        self notify(parms["state"]);
        continue;
      }

      if(parms["cycle_on_trigger"]) {
        curstate = door getscriptablepartstate("door", 1);

        if(isDefined(curstate) && issubstr(curstate, "open")) {
          door setscriptablepartstate("door", "closing", 0);
          self notify("closing");
        } else if(isDefined(curstate) && issubstr(curstate, "clos")) {
          door setscriptablepartstate("door", "opening", 0);
          self notify("opening");
        }

        continue;
      }

      self.doorclosetime = gettime() + 250;
      curstate = door getscriptablepartstate("door", 1);

      if(isDefined(curstate) && issubstr(curstate, "clos") || curstate == "static") {
        door setscriptablepartstate("door", "opening", 0);
        self notify("opening");
        door thread closedoortimeout(self);
      }
    }

    if(parms["delete"]) {
      self delete();
    }
  }
}

function closedoortimeout(trigger) {
  self notify("41943d3e82b2d3b2");
  self endon("41943d3e82b2d3b2");
  self endon("death_or_disconnet");
  trigger endon("death_or_disconnet");

  while(gettime() < trigger.doorclosetime) {
    waitframe();
  }

  self setscriptablepartstate("door", "closing", 0);
  trigger notify("closing");
}