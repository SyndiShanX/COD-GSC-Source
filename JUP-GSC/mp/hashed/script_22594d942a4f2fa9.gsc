/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_22594d942a4f2fa9.gsc
*************************************************/

#using script_d74ae0b4aa21186;
#using scripts\engine\utility;
#namespace namespace_cd1f26d31e0fc552;

function createevent(radius, duration) {
  event = function_c74368899713e7e6();
  event.radiussquared = radius * radius;
  event.duration = duration;
  event.result = [];
  eventstream = self.mind.eventstream;
  eventstream.var_b726268175e85134 = event;
  eventstream.events[eventstream.events.size] = event;
}

function getevent() {
  event = self.mind.eventstream.var_b726268175e85134;

  if(!event.evaluated) {
    if(event.result.size > 0) {
      foreach(entnum, lastview in event.result) {
        var_23818fd0489c7005 = isexpired(lastview.time, lastview.origin);

        if(var_23818fd0489c7005) {
          event.result[entnum] = undefined;
        }
      }
    }

    foreach(player in level.players) {
      skip = !isDefined(player) || self.team == player.team;

      if(skip) {
        continue;
      }

      lasttime = self lastknowntime(player);
      lastpos = self lastknownpos(player);
      nolasttime = lasttime <= 0;
      var_b9f15fe7c92886c0 = !isvector(lastpos);
      entitynumber = player getentitynumber();
      shoulddelete = nolasttime || var_b9f15fe7c92886c0 || isexpired(lasttime, lastpos);

      if(shoulddelete) {
        if(isDefined(event.result[entitynumber])) {
          event.result[entitynumber] = undefined;
        }

        continue;
      }

      entry = event.result[entitynumber];

      if(!isDefined(entry)) {
        entry = spawnStruct();
        entry.entnum = entitynumber;
        entry.valid = 1;
        entry.time = lasttime;
        entry.origin = lastpos;
        event.result[entitynumber] = entry;
        continue;
      }

      if(lasttime != entry.time) {
        entry.valid = 1;
        entry.time = lasttime;
        entry.origin = lastpos;
      }
    }

    event.evaluated = 1;
  }

  return event.result;
}

function getduration() {
  event = self.mind.eventstream.var_b726268175e85134;
  return event.duration;
}

function invalidateentry(entitynumber) {
  event = self.mind.eventstream.var_b726268175e85134;
  entry = event.result[entitynumber];

  if(isDefined(entry)) {
    entry.valid = 0;
  }
}

function isexpired(time, position) {
  event = self.mind.eventstream.var_b726268175e85134;
  return (gettime() - time) / 1000 > event.duration || distancesquared(self.origin, position) > event.radiussquared;
}