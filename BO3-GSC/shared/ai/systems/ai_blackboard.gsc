/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\ai_blackboard.gsc
*************************************************/

#namespace blackboard;

function autoexec main() {
  _initializeblackboard();
}

function private _initializeblackboard() {
  level.__ai_blackboard = [];
  level thread _updateevents();
}

function private _updateevents() {
  waittime = 0.05;
  updatemillis = waittime * 1000;
  while (true) {
    foreach(eventname, events in level.__ai_blackboard) {
      liveevents = [];
      foreach(event in events) {
        event.ttl = event.ttl - updatemillis;
        if(event.ttl > 0) {
          liveevents[liveevents.size] = event;
        }
      }
      level.__ai_blackboard[eventname] = liveevents;
    }
    wait(waittime);
  }
}

function addblackboardevent(eventname, data, timetoliveinmillis) {
  /# /
  #
  assert(isstring(eventname), "");
  assert(isdefined(data), "");
  assert(isint(timetoliveinmillis) && timetoliveinmillis > 0, "");
  event = spawnstruct();
  event.data = data;
  event.timestamp = gettime();
  event.ttl = timetoliveinmillis;
  if(!isdefined(level.__ai_blackboard[eventname])) {
    level.__ai_blackboard[eventname] = [];
  } else if(!isarray(level.__ai_blackboard[eventname])) {
    level.__ai_blackboard[eventname] = array(level.__ai_blackboard[eventname]);
  }
  level.__ai_blackboard[eventname][level.__ai_blackboard[eventname].size] = event;
}

function getblackboardevents(eventname) {
  if(isdefined(level.__ai_blackboard[eventname])) {
    return level.__ai_blackboard[eventname];
  }
  return [];
}

function removeblackboardevents(eventname) {
  if(isdefined(level.__ai_blackboard[eventname])) {
    level.__ai_blackboard[eventname] = undefined;
  }
}