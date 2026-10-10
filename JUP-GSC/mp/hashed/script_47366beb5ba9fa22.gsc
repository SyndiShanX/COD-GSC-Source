/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_47366beb5ba9fa22.gsc
*************************************************/

#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#using scripts\mp\gameobjects;
#namespace namespace_4b022bbde284cec1;

function createevent() {
  event = function_c74368899713e7e6();
  event.result = [];
  eventstream = self.mind.eventstream;
  eventstream.var_c0f0c13703c22359 = event;
  eventstream.events[eventstream.events.size] = event;
}

function getevent() {
  event = self.mind.eventstream.var_c0f0c13703c22359;

  if(!event.evaluated) {
    if(event.result.size > 0) {
      event.result = [];
    }

    if(!isDefined(level.objectives)) {
      return event.result;
    }

    foreach(obj in level.objectives) {
      switch (level.gametype) {
        case #"hash_ca6516c10db2c95":
        case #"hash_2f5af599c5c220d3":
        case #"hash_f4a9126c03d3385b":
          if(self.team == obj scripts\mp\gameobjects::getownerteam()) {
            continue;
          }

          break;
        case #"hash_6efb0f59a62300fb":
        case #"hash_cf3000550ee7e8b3":
        case #"hash_ec72fd25bbbac99e":
          if(!istrue(obj.active)) {
            continue;
          }

          break;
      }

      event.result[event.result.size] = obj;
    }

    if(event.result.size > 1) {
      event.result = array_sort_with_func(event.result, &function_cb083b117c783af);
    }

    event.evaluated = 1;
  }

  return event.result;
}

function function_cb083b117c783af(flaga, flagb) {
  return distancesquared(flaga.curorigin, self.origin) < distancesquared(flagb.curorigin, self.origin);
}

function function_b4e30a9548aa351b() {
  assert(level.gametype == "<dev string:x1c>" || level.gametype == "<dev string:x24>" || level.gametype == "<dev string:x32>");
  nexthardpoint = level.prevzoneindex % level.objectives.size + 1;
  return level.objectives[string(nexthardpoint)];
}