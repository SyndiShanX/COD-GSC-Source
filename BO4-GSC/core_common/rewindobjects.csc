/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\rewindobjects.csc
***********************************************/

#include scripts\core_common\system_shared;

#namespace rewindobjects;

autoexec __init__system__() {
  system::register(#"rewindobjects", &__init__, undefined, undefined);
}

__init__() {
  level.rewindwatcherarray = [];
}

initrewindobjectwatchers(localclientnum) {
  level.rewindwatcherarray[localclientnum] = [];
  createnapalmrewindwatcher(localclientnum);
  createairstrikerewindwatcher(localclientnum);
  level thread watchrewindableevents(localclientnum);
}

watchrewindableevents(localclientnum) {
  for(;;) {
    if(isDefined(level.rewindwatcherarray[localclientnum])) {
      rewindwatcherkeys = getarraykeys(level.rewindwatcherarray[localclientnum]);

      for(i = 0; i < rewindwatcherkeys.size; i++) {
        rewindwatcher = level.rewindwatcherarray[localclientnum][rewindwatcherkeys[i]];

        if(!isDefined(rewindwatcher)) {
          continue;
        }

        if(!isDefined(rewindwatcher.event)) {
          continue;
        }

        timekeys = getarraykeys(rewindwatcher.event);

        for(j = 0; j < timekeys.size; j++) {
          timekey = timekeys[j];

          if(rewindwatcher.event[timekey].inprogress == 1) {
            continue;
          }

          if(getservertime(0) >= timekey) {
            rewindwatcher thread startrewindableevent(localclientnum, timekey);
          }
        }
      }
    }

    wait 0.1;
  }
}

startrewindableevent(localclientnum, timekey) {
  player = function_5c10bd79(localclientnum);
  level endon("demo_jump" + localclientnum);
  self.event[timekey].inprogress = 1;
  allfunctionsstarted = 0;

  while(allfunctionsstarted == 0) {
    allfunctionsstarted = 1;
    assert(isDefined(self.timedfunctions));
    timedfunctionkeys = getarraykeys(self.timedfunctions);

    for(i = 0; i < timedfunctionkeys.size; i++) {
      timedfunction = self.timedfunctions[timedfunctionkeys[i]];
      timedfunctionkey = timedfunctionkeys[i];

      if(self.event[timekey].timedfunction[timedfunctionkey] == 1) {
        continue;
      }

      starttime = timekey + int(timedfunction.starttimesec * 1000);

      if(starttime > getservertime(0)) {
        allfunctionsstarted = 0;
        continue;
      }

      self.event[timekey].timedfunction[timedfunctionkey] = 1;
      level thread[[timedfunction.func]](localclientnum, starttime, timedfunction.starttimesec, self.event[timekey].data);
    }

    wait 0.1;
  }
}

createnapalmrewindwatcher(localclientnum) {
  napalmrewindwatcher = createrewindwatcher(localclientnum, "napalm");
  timeincreasebetweenplanes = 0;
}

createairstrikerewindwatcher(localclientnum) {
  airstrikerewindwatcher = createrewindwatcher(localclientnum, "airstrike");
}

createrewindwatcher(localclientnum, name) {
  player = function_5c10bd79(localclientnum);

  if(!isDefined(level.rewindwatcherarray[localclientnum])) {
    level.rewindwatcherarray[localclientnum] = [];
  }

  rewindwatcher = getrewindwatcher(localclientnum, name);

  if(!isDefined(rewindwatcher)) {
    rewindwatcher = spawnStruct();
    level.rewindwatcherarray[localclientnum][level.rewindwatcherarray[localclientnum].size] = rewindwatcher;
  }

  rewindwatcher.name = name;
  rewindwatcher.event = [];
  rewindwatcher thread resetondemojump(localclientnum);
  return rewindwatcher;
}

resetondemojump(localclientnum) {
  for(;;) {
    level waittill("demo_jump" + localclientnum);
    self.inprogress = 0;
    timedfunctionkeys = getarraykeys(self.timedfunctions);

    for(i = 0; i < timedfunctionkeys.size; i++) {
      self.timedfunctions[timedfunctionkeys[i]].inprogress = 0;
    }

    eventkeys = getarraykeys(self.event);

    for(i = 0; i < eventkeys.size; i++) {
      self.event[eventkeys[i]].inprogress = 0;
      timedfunctionkeys = getarraykeys(self.event[eventkeys[i]].timedfunction);

      for(index = 0; index < timedfunctionkeys.size; index++) {
        self.event[eventkeys[i]].timedfunction[timedfunctionkeys[index]] = 0;
      }
    }
  }
}

addtimedfunction(name, func, relativestarttimeinsecs) {
  if(!isDefined(self.timedfunctions)) {
    self.timedfunctions = [];
  }

  assert(!isDefined(self.timedfunctions[name]));
  self.timedfunctions[name] = spawnStruct();
  self.timedfunctions[name].inprogress = 0;
  self.timedfunctions[name].func = func;
  self.timedfunctions[name].starttimesec = relativestarttimeinsecs;
}

getrewindwatcher(localclientnum, name) {
  if(!isDefined(level.rewindwatcherarray[localclientnum])) {
    return undefined;
  }

  for(watcher = 0; watcher < level.rewindwatcherarray[localclientnum].size; watcher++) {
    if(level.rewindwatcherarray[localclientnum][watcher].name == name) {
      return level.rewindwatcherarray[localclientnum][watcher];
    }
  }

  return undefined;
}

addrewindableeventtowatcher(starttime, data) {
  if(isDefined(self.event[starttime])) {
    return;
  }

  self.event[starttime] = spawnStruct();
  self.event[starttime].data = data;
  self.event[starttime].inprogress = 0;

  if(isDefined(self.timedfunctions)) {
    timedfunctionkeys = getarraykeys(self.timedfunctions);
    self.event[starttime].timedfunction = [];

    for(i = 0; i < timedfunctionkeys.size; i++) {
      timedfunctionkey = timedfunctionkeys[i];
      self.event[starttime].timedfunction[timedfunctionkey] = 0;
    }
  }
}

servertimedmoveto(localclientnum, startpoint, endpoint, starttime, duration) {
  level endon("demo_jump" + localclientnum);
  timeelapsed = (getservertime(0) - starttime) * 0.001;
  assert(duration > 0);
  dojump = 1;

  if(timeelapsed < 0.02) {
    dojump = 0;
  }

  if(timeelapsed < duration) {
    movetime = duration - timeelapsed;

    if(dojump) {
      jumppoint = getpointonline(startpoint, endpoint, timeelapsed / duration);
      self.origin = jumppoint;
    }

    self moveto(endpoint, movetime, 0, 0);
    return 1;
  }

  self.origin = endpoint;
  return 0;
}

servertimedrotateto(localclientnum, angles, starttime, duration, timein, timeout) {
  level endon("demo_jump" + localclientnum);
  timeelapsed = (getservertime(0) - starttime) * 0.001;

  if(!isDefined(timein)) {
    timein = 0;
  }

  if(!isDefined(timeout)) {
    timeout = 0;
  }

  assert(duration > 0);

  if(timeelapsed < duration) {
    rotatetime = duration - timeelapsed;
    self rotateto(angles, rotatetime, timein, timeout);
    return 1;
  }

  self.angles = angles;
  return 0;
}

waitforservertime(localclientnum, timefromstart) {
  while(timefromstart > getservertime(0)) {
    waitframe(1);
  }
}

removecliententonjump(clientent, localclientnum) {
  clientent endon(#"complete");
  player = function_5c10bd79(localclientnum);
  level waittill("demo_jump" + localclientnum);
  clientent notify(#"delete");
  clientent forcedelete();
}

getpointonline(startpoint, endpoint, ratio) {
  nextpoint = (startpoint[0] + (endpoint[0] - startpoint[0]) * ratio, startpoint[1] + (endpoint[1] - startpoint[1]) * ratio, startpoint[2] + (endpoint[2] - startpoint[2]) * ratio);
  return nextpoint;
}