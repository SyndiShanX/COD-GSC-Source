/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\script.gsc
**************************************/

#namespace script;

function waittillslowprocessallowed(allowloop, var_9cacc25b15fb0b32) {
  if(level.lastslowprocessframe == gettime()) {
    if(allowloop) {
      do {
        waitframe();

        if(var_9cacc25b15fb0b32) {
          waittillframeend();
        }
      }
      while(level.lastslowprocessframe == gettime());
    } else {
      waitframe();

      if(var_9cacc25b15fb0b32) {
        waittillframeend();
      }

      if(level.lastslowprocessframe == gettime()) {
        waitframe();

        if(var_9cacc25b15fb0b32) {
          waittillframeend();
        }

        if(level.lastslowprocessframe == gettime()) {
          waitframe();

          if(var_9cacc25b15fb0b32) {
            waittillframeend();
          }

          if(level.lastslowprocessframe == gettime()) {
            waitframe();

            if(var_9cacc25b15fb0b32) {
              waittillframeend();
            }
          }
        }
      }
    }
  }

  level.lastslowprocessframe = gettime();
}

function function_f82d6641490331a9() {
  level.lastslowprocessframe = maxint(level.lastslowprocessframe, gettime());
}

function function_e1c5c030f026248c() {
  return gettime() - (level.lastslowprocessframe ?? 0);
}

function function_7cae34dfec48a6d1() {
  return level.lastslowprocessframe === gettime();
}

function queuecreate(queuename) {
  if(!isDefined(level.queues)) {
    level.queues = [];
  }

  assert(!isDefined(level.queues[queuename]));
  level.queues[queuename] = [];
}

function queueadd(queuename, entity) {
  assert(isDefined(level.queues[queuename]));
  level.queues[queuename][level.queues[queuename].size] = entity;
}

function queueremovefirst(queuename) {
  assert(isDefined(level.queues[queuename]));
  first = undefined;
  newqueue = [];

  foreach(element in level.queues[queuename]) {
    if(!isDefined(element)) {
      continue;
    }

    if(!isDefined(first)) {
      first = element;
      continue;
    }

    newqueue[newqueue.size] = element;
  }

  level.queues[queuename] = newqueue;
  return first;
}

function limitdecimalplaces(value, places) {
  modifier = int(pow(10, places));
  return floor(value * modifier) / modifier;
}

function rounddecimalplaces(value, places, style = "nearest") {
  modifier = int(pow(10, places));
  newvalue = value * modifier;

  if(style == "up") {
    roundedvalue = ceil(newvalue);
  } else if(style == "down") {
    roundedvalue = floor(newvalue);
  } else {
    roundedvalue = newvalue + 0.5;
  }

  newvalue = int(roundedvalue) / modifier;
  return newvalue;
}

function stringtofloat(stringval) {
  floatelements = strtok(stringval, ".");
  floatval = int(floatelements[0]);

  if(isDefined(floatelements[1])) {
    modifier = 1;

    for(i = 0; i < floatelements[1].size; i++) {
      modifier *= 0.1;
    }

    floatval += int(floatelements[1]) * modifier;
  }

  if(stringval[0] == "-") {
    floatval *= -1;
  }

  return floatval;
}

function delayentdelete(time) {
  self endon("death");
  wait time;

  if(isDefined(self)) {
    self delete();
  }
}

function bufferednotify(notification, ...) {
  thread bufferednotify_internal(notification, {
    #params: vararg, #count: varargcount
  });
}

function private function_284c2ae5583007bc() {
  var_1f68bf13bc904879 = level.gametypebundle.var_d5a83b7f03ff465e ?? #"hash_dfcb6a2fdbc977b0";

  switch (var_1f68bf13bc904879) {
    case #"hash_dfcb6a2fdbc977b0":
    default:
      waittillframeend();
      return;
    case #"hash_16a4c2b6f68453e0":
      do {
        waitframe();
        waittillframeend();
      }
      while(function_7cae34dfec48a6d1());

      return;
  }
}

function private function_de23bc0ca8d2eba() {
  var_1f68bf13bc904879 = level.gametypebundle.var_d5a83b7f03ff465e ?? #"hash_dfcb6a2fdbc977b0";

  switch (var_1f68bf13bc904879) {
    case #"hash_dfcb6a2fdbc977b0":
    default:
      waitframe();
      return;
    case #"hash_16a4c2b6f68453e0":
      do {
        waitframe();
        waittillframeend();
      }
      while(function_7cae34dfec48a6d1());

      return;
  }
}

function private bufferednotify_internal(notification, var_3e69b0b43bd155b7) {
  self endon("disconnect");
  level endon("game_ended");
  uniqueendonnotify = "bufferedNotify_" + notification;
  self notify(uniqueendonnotify);
  self endon(uniqueendonnotify);

  if(!isDefined(self.bufferednotifications)) {
    self.bufferednotifications = [];
  }

  if(!isDefined(self.bufferednotifications[notification])) {
    self.bufferednotifications[notification] = [];
  }

  self.bufferednotifications[notification][self.bufferednotifications[notification].size] = var_3e69b0b43bd155b7;
  function_284c2ae5583007bc();

  while(isDefined(self) && self.bufferednotifications[notification].size > 0) {
    var_3e69b0b43bd155b7 = self.bufferednotifications[notification][0];
    self notify(notification, flat_args(var_3e69b0b43bd155b7.params, var_3e69b0b43bd155b7.count));
    self.bufferednotifications[notification][0] = undefined;
    function_cdc669dbc8ea2101(self.bufferednotifications[notification]);
    function_de23bc0ca8d2eba();
  }
}

function notifyafterframeend(waittillmsg, var_e3a1804111bee4c8) {
  assert(isDefined(waittillmsg), "<dev string:x24>");
  assert(isDefined(var_e3a1804111bee4c8), "<dev string:x5f>");
  self waittill(waittillmsg);
  waittillframeend();
  self notify(var_e3a1804111bee4c8);
}

function delaysetclientomnvar(delaytime, omnvar, value) {
  self endon("disconnect");
  wait delaytime;
  self setclientomnvar(omnvar, value);
}

function strip_suffix(lookupstring, stripstring) {
  if(lookupstring.size <= stripstring.size) {
    return lookupstring;
  }

  if(getsubstr(lookupstring, lookupstring.size - stripstring.size, lookupstring.size) == stripstring) {
    return getsubstr(lookupstring, 0, lookupstring.size - stripstring.size);
  }

  return lookupstring;
}

function vectortoanglessafe(forward, up) {
  right = vectorcross(forward, up);
  up = vectorcross(right, forward);
  angles = axistoangles(forward, right, up);
  return angles;
}

function heap(type) {
  assert(type == "<dev string:x97>" || type == "<dev string:x9e>", "<dev string:xa5>");
  h = spawnStruct();
  h.nvals = 0;
  h.vals = [];

  if(type == "max") {
    h.swap = &_heaplessthan;
  } else if(type == "min") {
    h.swap = &_heapgreaterthan;
  }

  return h;
}

function heapsize() {
  return self.nvals;
}

function heappeek() {
  return self.vals[1];
}

function heappop() {
  if(self.nvals == 0) {
    return undefined;
  }

  if(self.nvals == 1) {
    val = self.vals[1];
    self.vals[1] = undefined;
    self.nvals = 0;
    return val;
  }

  val = self.vals[1];
  self.vals[1] = self.vals[self.nvals];
  self.vals[self.nvals] = undefined;
  _heapify(1);
  self.nvals -= 1;
  return val;
}

function heapinsert(val) {
  self.vals[self.nvals + 1] = val;
  i = self.nvals + 1;
  parent = _heapparent(i);

  while(isDefined(parent)) {
    if([[self.swap]](parent, i)) {
      temp = self.vals[parent];
      self.vals[parent] = self.vals[i];
      self.vals[i] = temp;
      i = parent;
      parent = _heapparent(i);
      continue;
    }

    break;
  }

  self.nvals += 1;
}

function printheap() {
  print("<dev string:xc9>");
  vals = [];
  size = self.nvals;

  for(i = 0; i < size; i++) {
    vals[i] = heappop();
  }

  for(i = 0; i < vals.size; i++) {
    heapinsert(vals[i]);
  }

  for(i = 0; i < vals.size; i++) {
    print(vals[i] + "<dev string:xd0>");
  }

  print("<dev string:xc9>");
}

function _heapgreaterthan(i, j) {
  return self.vals[i] > self.vals[j];
}

function _heaplessthan(i, j) {
  return self.vals[i] < self.vals[j];
}

function _heapify(i) {
  lc = _heapleftchild(i);
  rc = _heaprightchild(i);
  newidx = undefined;
  swapleft = 0;

  if(isDefined(lc)) {
    swapleft = self[[self.swap]](i, lc);
  }

  swapright = 0;

  if(isDefined(rc)) {
    swapright = self[[self.swap]](i, rc);
  }

  if(!swapleft && !swapright) {
    return;
  } else if(swapleft && !swapright) {
    newidx = lc;
  } else if(!swapleft && swapright) {
    newidx = rc;
  } else if(self[[self.swap]](lc, rc)) {
    newidx = rc;
  } else {
    newidx = lc;
  }

  temp = self.vals[i];
  self.vals[i] = self.vals[newidx];
  self.vals[newidx] = temp;
  _heapify(newidx);
}

function _heapleftchild(i) {
  if(!isDefined(self.vals[2 * i])) {
    return undefined;
  }

  return 2 * i;
}

function _heaprightchild(i) {
  if(!isDefined(self.vals[2 * i + 1])) {
    return undefined;
  }

  return 2 * i + 1;
}

function _heapparent(i) {
  if(i == 1) {
    return undefined;
  }

  return int(floor(i / 2));
}

function isnumbermultipleof(number, factor) {
  return number > 0 && number % factor == 0;
}

function demoforcesre(message) {
  throw (message);
}

function function_2e2007575f92910d(message) {
  recordeventforsreparser("sre_error_event", "SRE LOGGING", message);
}

function function_789a02669a1a12e9(dvar, message) {
  if(getdvarint(dvar, 0)) {
    recordeventforsreparser("sre_error_event", "SRE LOGGING DVAR GATED", message);
  }
}