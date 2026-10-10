/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\mp\utility\script.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace script;

function waittillslowprocessallowed(allowloop) {
  if(level.lastslowprocessframe == gettime()) {
    if(isDefined(allowloop) && allowloop) {
      while(level.lastslowprocessframe == gettime()) {
        wait 0.05;
      }
    } else {
      wait 0.05;

      if(level.lastslowprocessframe == gettime()) {
        wait 0.05;

        if(level.lastslowprocessframe == gettime()) {
          wait 0.05;

          if(level.lastslowprocessframe == gettime()) {
            wait 0.05;
          }
        }
      }
    }
  }

  level.lastslowprocessframe = gettime();
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

function quicksort(array, compare_func) {
  if(!isDefined(compare_func)) {
    compare_func = &default_compare;
  }

  l = 0;
  h = array.size - 1;
  stack = [l, h];
  top = 1;

  while(top >= 0) {
    h = stack[top];
    top--;
    l = stack[top];
    top--;

    if(h - l <= 9) {
      h++;

      while(l < h) {
        x = array[l];
        j = l - 1;

        while(j >= 0 && [[compare_func]](x, array[j])) {
          array[j + 1] = array[j];
          j -= 1;
        }

        array[j + 1] = x;
        l += 1;
      }

      continue;
    }

    x = array[h];
    p = l - 1;

    for(j = l; j <= h - 1; j++) {
      if([[compare_func]](array[j], x)) {
        p++;
        temp = array[p];
        array[p] = array[j];
        array[j] = temp;
      }
    }

    p++;
    temp = array[p];
    array[p] = array[h];
    array[h] = temp;

    if(p - 1 > l) {
      top++;
      stack[top] = l;
      top++;
      stack[top] = p - 1;
    }

    if(p + 1 < h) {
      top++;
      stack[top] = p + 1;
      top++;
      stack[top] = h;
    }
  }

  return array;
}

function default_compare(left, right) {
  return left <= right;
}

function limitdecimalplaces(value, places) {
  modifier = 1;

  for(i = 0; i < places; i++) {
    modifier *= 10;
  }

  newvalue = value * modifier;
  newvalue = int(newvalue);
  newvalue /= modifier;
  return newvalue;
}

function rounddecimalplaces(value, places, style) {
  if(!isDefined(style)) {
    style = "nearest";
  }

  modifier = 1;

  for(i = 0; i < places; i++) {
    modifier *= 10;
  }

  newvalue = value * modifier;

  if(style == "up") {
    var_ce526f59e2a5ad3f = ceil(newvalue);
  } else if(style == "down") {
    var_ce526f59e2a5ad3f = floor(newvalue);
  } else {
    var_ce526f59e2a5ad3f = newvalue + 0.5;
  }

  newvalue = int(var_ce526f59e2a5ad3f);
  newvalue /= modifier;
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

  return floatval;
}

function array_remove_keep_index(ents, remover) {
  newents = [];

  foreach(ent in ents) {
    if(ent != remover) {
      newents[index] = ent;
    }
  }

  return newents;
}

function delayentdelete(time) {
  self endon("death");
  wait time;

  if(isDefined(self)) {
    self delete();
  }
}

function roundup(floatvalue) {
  if(floatvalue - int(floatvalue) >= 0.5) {
    return int(floatvalue + 1);
  }

  return int(floatvalue);
}

function bufferednotify(notification, param1, param2, param3, param4, param5, param6, param7, param8) {
  thread bufferednotify_internal(notification, param1, param2, param3, param4, param5, param6, param7, param8);
}

function bufferednotify_internal(notification, param1, param2, param3, param4, param5, param6, param7, param8) {
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

  parameters = spawnStruct();
  parameters.param1 = param1;
  parameters.param2 = param2;
  parameters.param3 = param3;
  parameters.param4 = param4;
  parameters.param5 = param5;
  parameters.param6 = param6;
  parameters.param7 = param7;
  parameters.param8 = param8;
  self.bufferednotifications[notification][self.bufferednotifications[notification].size] = parameters;
  waittillframeend();

  while(self.bufferednotifications[notification].size > 0) {
    parameters = self.bufferednotifications[notification][0];
    self notify(notification, parameters.param1, parameters.param2, parameters.param3, parameters.param4, parameters.param5, parameters.param6, parameters.param7, parameters.param8);
    self.bufferednotifications[notification] = array_remove_index(self.bufferednotifications[notification], 0);
    waitframe();
  }
}

function notifyafterframeend(waittillmsg, var_7239f8830ef22b43) {
  assertex(isDefined(waittillmsg), "notifyAfterFrameEnd() was not given a notify to wait on");
  assertex(isDefined(var_7239f8830ef22b43), "notifyAfterFrameEnd() was not given a notify to send");
  self waittill(waittillmsg);
  waittillframeend();
  self notify(var_7239f8830ef22b43);
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
  assertex(type == "max" || type == "min", "Heap type must be 'max' or 'min'");
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
  print("<dev string:x1c>");
  vals = [];
  size = self.nvals;

  for(i = 0; i < size; i++) {
    vals[i] = heappop();
  }

  for(i = 0; i < vals.size; i++) {
    heapinsert(vals[i]);
  }

  for(i = 0; i < vals.size; i++) {
    print(vals[i] + "<dev string:x20>");
  }

  print("<dev string:x1c>");
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
  forcesre = message == undefined;
}