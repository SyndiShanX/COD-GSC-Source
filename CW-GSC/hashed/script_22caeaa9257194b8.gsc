/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_22caeaa9257194b8.gsc
***********************************************/

#using script_566bf433dcd9d9c;
#using script_7cc5fb39b97494c4;
#using scripts\core_common\ai\systems\animation_state_machine_utility;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\gametypes\globallogic_utils;
#namespace doors_ai;

function private autoexec __init__system__() {
  system::register(#"doors_ai", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  if(function_550f629a()) {
    spawner::add_archetype_spawn_function(#"human", &ai_monitor_doors);
    spawner::add_archetype_spawn_function(#"human", &namespace_4f6b19b0::function_6249a416);
  }

  function_5ac4dc99("<dev string:x38>", 0);
}

function private postinit() {}

function private function_550f629a() {
  var_1cde154f = getgametypesetting(#"use_doors");
  var_5a23774b = getdvarint(#"disabledoors", 0);

  if(!is_true(var_1cde154f) || is_true(var_5a23774b)) {
    return;
  }

  a_doors = struct::get_array("scriptbundle_doors", "classname");
  a_doors = arraycombine(a_doors, getEntArray("smart_object_door", "script_noteworthy"), 0, 0);

  foreach(s_instance in a_doors) {
    s_door_bundle = getscriptbundle(s_instance.scriptbundlename);

    if(isDefined(s_door_bundle) && is_true(s_door_bundle.door_connect_paths)) {
      return 1;
    }
  }

  return 0;
}

function private door_manage_openers(c_door) {
  c_door.m_e_door endon(#"entitydeleted");
  c_door notify(#"hash_66ae5fc513adfddc");
  c_door endon(#"hash_66ae5fc513adfddc");
  mycenter = c_door doors::get_door_center(1);

  var_be457ed9 = (randomfloat(1), randomfloat(1), randomfloat(1));

  var_1bb1d9d4 = 72;

  while(true) {
    if(c_door flag::get("door_fully_open")) {
      return;
    }

    function_1eaaceab(c_door.var_d0ca7119);

    if(c_door.var_d0ca7119.size == 0) {
      return;
    }

    c_door.var_d0ca7119 = arraysortclosest(c_door.var_d0ca7119, c_door.m_e_door.origin);
    opener = c_door.var_d0ca7119[0];

    if(getdvarint(#"hash_33928bcf1b3e5487", 0)) {
      c_door thread function_cbb3e924(var_be457ed9);
    }

    closestdist = distance2d(mycenter, opener.origin);
    var_17b1d600 = 110;
    var_af33ff77 = length(opener getvelocity());

    if(var_af33ff77 > 90) {
      var_17b1d600 = 180;
    }

    if(closestdist <= var_17b1d600 && abs(mycenter[2] - opener.origin[2]) < var_1bb1d9d4 && !is_true(c_door.breached)) {
      results = opener function_a847c61f(4096, var_17b1d600 + 50);

      if(results.var_4e035bb7) {
        c_door thread door_manager_try_ai_opener(opener);
      }
    }

    foreach(guy in c_door.var_d0ca7119) {
      if(guy == opener && !is_true(c_door.breached)) {
        if(isDefined(guy.ai.waitingfordoor)) {
          guy stop_waiting_for_door();
        }
      }
    }

    waitframe(1);
  }
}

function private door_manager_try_ai_opener(opener) {
  if(is_true(self.lockedforai) || is_true(self.var_526bb929.lockedforai)) {
    return;
  }

  self.var_14439ba5 = opener;
  result = opener ai_open_try_animated(self);

  if(!is_true(result)) {
    function_50cd6f16(self.var_d0ca7119, "reset_door_check");
    self.var_14439ba5 = undefined;
    return;
  }
}

function function_50cd6f16(arrayref, str_notify) {
  array_size = arrayref.size;

  for(i = 0; i < array_size; i++) {
    elem = arrayref[i];

    if(isDefined(elem)) {
      elem notify(str_notify);
    }
  }
}

function private ai_open_try_animated(c_door) {
  self endon(#"death");
  c_door.m_e_door endon(#"entitydeleted");

  if(isDefined(self.ai.waitingfordoor)) {
    self stop_waiting_for_door();
  }

  self.ai.doortoopen = c_door;
  result = self waittilltimeout(6, #"opening_door");
  bsuccess = result._notify != # "timeout";

  if(bsuccess) {
    self waittilltimeout(4, #"opening_door_done");
  }

  if(isDefined(self.ai.doortoopen) && self.ai.doortoopen == c_door) {
    self.ai.doortoopen = undefined;
    self.ai.isopeningdoor = undefined;
  }

  return bsuccess;
}

function private door_add_opener(c_door) {
  if(isDefined(self.ai.currentdoor) && self.ai.currentdoor != c_door) {
    arrayremovevalue(self.ai.currentdoor.var_d0ca7119, self);
  }

  self.ai.currentdoor = c_door;

  if(!isDefined(c_door.var_d0ca7119)) {
    c_door.var_d0ca7119 = [];
  }

  c_door.var_d0ca7119[c_door.var_d0ca7119.size] = self;
}

function private remove_as_opener() {
  if(isDefined(self.ai.currentdoor)) {
    arrayremovevalue(self.ai.currentdoor.var_d0ca7119, self);
    self.ai.currentdoor = undefined;
  }
}

function private function_a8a940ac() {
  if(isDefined(self.ai.waitingfordoor)) {
    if(self.ai.waitingfordoor == self.ai.currentdoor) {
      return false;
    }
  }

  return true;
}

function private stop_waiting_for_door() {
  self notify(#"stop_waiting_for_door");

  self.ai.waitingfordoor = undefined;
}

function private function_cbb3e924(var_be457ed9) {
  foreach(i, g in self.var_d0ca7119) {
    if(isDefined(self.var_14439ba5) && self.var_14439ba5 == g) {
      circle(g.origin, 5, var_be457ed9, 0, 1, 1);
    }

    line(self.m_e_door.origin, g getEye(), var_be457ed9, 1, 0, 1);

    if(i == 0) {
      var_cab378c2 = "<dev string:x4d>" + self.m_e_door getentnum();
      self notify(#"door_debug", {
        #msg: var_cab378c2
      });
    }
  }
}

function private draw_node_line(node, time, color) {
  self endon(#"death");
  timer = gettime() + time * 1000;

  while(gettime() < timer) {
    line(self getEye(), node.origin, color, 0.5, 0, 1);
    wait 0.05;
  }
}

function private function_a07f8293() {
  self endon(#"death");
  oldmsg = "<dev string:x63>";
  newmsg = "<dev string:x63>";

  while(true) {
    result = self waittill(#"door_debug");
    msg = result.msg;
    newmsg = msg;
    self childthread update_debug(newmsg, oldmsg);
    oldmsg = newmsg;
  }
}

function private update_debug(newmsg, oldmsg) {
  self notify(#"new_msg");
  self endon(#"new_msg");
  var_852f740c = 1;
  displaytime = 5;
  steps = displaytime * 20;
  var_18c3a98a = var_852f740c / steps;
  time = gettime();

  while(gettime() < time + displaytime * 1000) {
    if(getdvarint(#"hash_33928bcf1b3e5487", 0)) {
      print3d(self getEye() + (0, 0, 15), newmsg, (1, 1, 1), 1, 0.3, 1);
      print3d(self getEye() + (0, 0, 10), oldmsg, (0.7, 0.7, 0.7), var_852f740c, 0.3, 1);
    }

    var_852f740c -= var_18c3a98a;
    wait 0.05;
  }
}

function function_b0731097(var_59e58a96, maxcheckdist) {
  path_array = undefined;
  results = undefined;
  distance = 0;
  goalinfo = self function_4794d6a3();
  goalpos = goalinfo.goalpos;

  if(self isinscriptedstate()) {
    return undefined;
  }

  if(isDefined(goalinfo.goalvolume)) {
    var_3d43e297 = self findbestcovernode();

    if(isDefined(var_3d43e297)) {
      goalpos = var_3d43e297.origin;
    } else {
      return undefined;
    }
  }

  path_array = self function_f14f56a8();

  if(!isDefined(path_array) || path_array.size <= 1) {
    return undefined;
  }

  mask = 8;

  for(i = 0; i < path_array.size; i++) {
    path_array[i] += (0, 0, 20);
  }

  for(i = 1; i < path_array.size; i++) {
    if(isDefined(maxcheckdist) && distance > maxcheckdist) {
      return undefined;
    }

    prevpos = path_array[i - 1];
    nextpos = path_array[i];
    results = physicstrace(prevpos, nextpos, (-5, -5, 0), (5, 5, 0), self, mask);

    if(isDefined(results[#"entity"])) {
      hitent = results[#"entity"];

      if(isDefined(hitent.c_door)) {
        var_fe505a43 = hitent function_808e656();

        if(var_fe505a43 &var_59e58a96) {
          hitpos = results[#"position"];
          distance += distance(prevpos, hitpos);

          if(isDefined(maxcheckdist) && distance > maxcheckdist) {
            return undefined;
          } else {
            return_struct = spawnStruct();
            return_struct.hitpos = hitpos;
            return_struct.hitent = hitent;
            return return_struct;
          }
        }
      }
    }

    distance += distance(prevpos, nextpos);
  }

  return undefined;
}

function function_13f8cd4c(e_door) {
  if(!isDefined(e_door) || !isDefined(e_door.c_door) || e_door.c_door flag::get("animating")) {
    return undefined;
  }

  if(e_door.c_door flag::get("door_pushable") && !e_door.c_door flag::get("door_fully_open") || !e_door.c_door flag::get("open")) {
    return e_door;
  }

  return undefined;
}

function private ai_monitor_doors() {
  self endon(#"death");

  self thread function_a07f8293();

  while(true) {
    var_12d56c89 = self waittill(#"path_set", #"reset_door_check");
    result = var_12d56c89._notify;

    if(isDefined(self.ai.isopeningdoor)) {
      continue;
    }

    if(isDefined(self.ai.waitingfordoor)) {
      if(isDefined(result) && result == "path_set" && isDefined(self.doornode) && isDefined(self.pathgoalpos) && distance2dsquared(self.pathgoalpos, self.doornode.origin) < 4) {
        continue;
      }

      self stop_waiting_for_door();
    }

    self remove_as_opener();
    var_88e76247 = 0;
    possibledoor = undefined;

    while(true) {
      results = self function_a847c61f(4096);
      doorloc = results.entrypoint[0];
      possibledoor = function_13f8cd4c(results.entity[0]);

      if(isDefined(doorloc)) {
        if(isDefined(possibledoor)) {
          doororigin = possibledoor.c_door doors::get_door_bottom_center();

          if(distancesquared(self.origin, doororigin) < 400) {
            var_da7ac3f6 = vectornormalize(doororigin - self.origin);

            if(vectordot(self.lookaheaddir, var_da7ac3f6) < -0.707) {
              wait 2;
              continue;
            }
          }

          self notify(#"door_debug", {
            #msg: "<dev string:x67>" + possibledoor getentnum()
          });

          var_88e76247 = 1;
          break;
        } else {
          wait 0.2;
          continue;
        }
      } else {
        break;
      }

      if(var_88e76247) {
        break;
      }

      wait 0.05;
    }

    if(!var_88e76247) {
      continue;
    }

    self door_add_opener(possibledoor.c_door);
    level thread door_manage_openers(possibledoor.c_door);
  }
}