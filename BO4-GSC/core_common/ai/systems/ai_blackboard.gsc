/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\ai_blackboard.gsc
****************************************************/

#namespace blackboard;

autoexec main() {
  _initializeblackboard();
}

private _initializeblackboard() {
  level.__ai_blackboard = [];
  level thread _updateevents();
}

private _updateevents() {
  waittime = 1 * float(function_60d95f53()) / 1000;
  updatemillis = int(waittime * 1000);

  while(true) {
    foreach(eventname, events in level.__ai_blackboard) {
      liveevents = [];

      foreach(event in events) {
        event.ttl -= updatemillis;

        if(event.ttl > 0) {
          liveevents[liveevents.size] = event;
        }
      }

      level.__ai_blackboard[eventname] = liveevents;
    }

    wait waittime;
  }
}

addblackboardevent(eventname, data, timetoliveinmillis) {
  assert(isstring(eventname) || ishash(eventname), "<dev string:x38>");
  assert(isDefined(data), "<dev string:x7d>");
  assert(isint(timetoliveinmillis) && timetoliveinmillis > 0, "<dev string:xb4>");

  event = spawnStruct();
  event.data = data;
  event.timestamp = gettime();
  event.ttl = timetoliveinmillis;

  if(!isDefined(level.__ai_blackboard[eventname])) {
    level.__ai_blackboard[eventname] = [];
  } else if(!isarray(level.__ai_blackboard[eventname])) {
    level.__ai_blackboard[eventname] = array(level.__ai_blackboard[eventname]);
  }

  level.__ai_blackboard[eventname][level.__ai_blackboard[eventname].size] = event;
}

getblackboardevents(eventname) {
  if(isDefined(level.__ai_blackboard[eventname])) {
    return level.__ai_blackboard[eventname];
  }

  return [];
}

removeblackboardevents(eventname) {
  if(isDefined(level.__ai_blackboard[eventname])) {
    level.__ai_blackboard[eventname] = undefined;
  }
}