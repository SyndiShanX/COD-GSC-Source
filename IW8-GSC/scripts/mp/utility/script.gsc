/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\utility\script.gsc
***********************************************/

function waittillslowprocessallowed(var_0) {
  if(level.lastslowprocessframe == gettime()) {
    if(isDefined(var_0) && var_0) {
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

function queuecreate(var_0) {
  if(!isDefined(level.queues)) {
    level.queues = [];
  }

  level.queues[var_0] = [];
}

function queueadd(var_0, var_1) {
  level.queues[var_0][level.queues[var_0].size] = var_1;
}

function queueremovefirst(var_0) {
  var_1 = undefined;
  var_2 = [];

  foreach(var_4 in level.queues[var_0]) {
    if(!isDefined(var_4)) {
      continue;
    }

    if(!isDefined(var_1)) {
      var_1 = var_4;
      continue;
    }

    var_2 = var_4;
  }

  level.queues[var_0] = var_2;
  return var_1;
}

function quicksort(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = &juggernaut_dmg_modifier;
  }

  var_2 = 0;
  var_3 = var_0.size - 1;
  var_4 = [var_2, var_3];
  var_5 = 1;

  while(var_5 >= 0) {
    var_3 = var_4[var_5];
    var_5--;
    var_2 = var_4[var_5];
    var_5--;

    if(var_3 - var_2 <= 9) {
      var_3++;

      while(var_2 < var_3) {
        var_6 = var_0[var_2];
        var_7 = var_2 - 1;

        while(var_7 >= 0 && [[var_1]](var_6, var_0[var_7])) {
          var_0 = var_0[var_7];
          var_7 -= 1;
        }

        var_0 = var_6;
        var_2 += 1;
      }

      continue;
    }

    var_6 = var_0[var_3];
    var_8 = var_2 - 1;

    for(var_7 = var_2; var_7 <= var_3 - 1; var_7++) {
      if([[var_1]](var_0[var_7], var_6)) {
        var_8++;
        var_9 = var_0[var_8];
        var_0 = var_0[var_7];
        var_0 = var_9;
      }
    }

    var_8++;
    var_9 = var_0[var_8];
    var_0 = var_0[var_3];
    var_0 = var_9;

    if(var_8 - 1 > var_2) {
      var_5++;
      var_4 = var_2;
      var_5++;
      var_4 = var_8 - 1;
    }

    if(var_8 + 1 < var_3) {
      var_5++;
      var_4 = var_8 + 1;
      var_5++;
      var_4 = var_3;
    }
  }

  return var_0;
}

function juggernaut_dmg_modifier(var_0, var_1) {
  return var_0 <= var_1;
}

function limitdecimalplaces(var_0, var_1) {
  var_2 = 1;

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_2 *= 10;
  }

  var_4 = var_0 * var_2;
  var_4 = int(var_4);
  var_4 /= var_2;
  return var_4;
}

function rounddecimalplaces(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "nearest";
  }

  var_3 = 1;

  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_3 *= 10;
  }

  var_5 = var_0 * var_3;

  if(var_2 == "up") {
    var_6 = ceil(var_5);
  } else if(var_3 == "down") {
    var_6 = floor(var_6);
  } else {
    var_6 += 0.5;
  }

  var_6 = int(var_6);
  var_6 /= var_5;
  return var_6;
}

function stringtofloat(var_0) {
  var_1 = strtok(var_0, ".");
  var_2 = int(var_1[0]);

  if(isDefined(var_1[1])) {
    var_3 = 1;

    for(var_4 = 0; var_4 < var_1[1].size; var_4++) {
      var_3 *= 0.1;
    }

    var_2 += int(var_1[1]) * var_3;
  }

  return var_2;
}

function isstrstart(var_0, var_1) {
  return getsubstr(var_0, 0, var_1.size) == var_1;
}

function array_remove_keep_index(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(var_4 != var_1) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function delayentdelete(var_0) {
  self endon("death");
  wait var_0;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function roundup(var_0) {
  if(var_0 - int(var_0) >= 0.5) {
    return int(var_0 + 1);
  }

  return int(var_0);
}

function bufferednotify(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  thread bufferednotify_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

function bufferednotify_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("disconnect");
  level endon("game_ended");
  var_9 = "bufferedNotify_" + var_0;
  self notify(var_9);
  self endon(var_9);

  if(!isDefined(self.bufferednotifications)) {
    self.bufferednotifications = [];
  }

  if(!isDefined(self.bufferednotifications[var_0])) {
    self.bufferednotifications[var_0] = [];
  }

  var_10 = spawnStruct();
  var_10.param1 = var_1;
  var_10.param2 = var_2;
  var_10.param3 = var_3;
  var_10.param4 = var_4;
  var_10.param5 = var_5;
  var_10.param6 = var_6;
  var_10.param7 = var_7;
  var_10.param8 = var_8;
  self.bufferednotifications[var_0][self.bufferednotifications[var_0].size] = var_10;
  waittillframeend();

  while(self.bufferednotifications[var_0].size > 0) {
    var_10 = self.bufferednotifications[var_0][0];
    self notify(var_0, var_10.param1, var_10.param2, var_10.param3, var_10.param4, var_10.param5, var_10.param6, var_10.param7, var_10.param8);
    self.bufferednotifications[var_0] = scripts\engine\utility::array_remove_index(self.bufferednotifications[var_0], 0);
    waitframe();
  }
}

function notifyafterframeend(var_0, var_1) {
  self waittill(var_0);
  waittillframeend();
  self notify(var_1);
}

function delaysetclientomnvar(var_0, var_1, var_2) {
  self endon("disconnect");
  wait var_0;
  self setclientomnvar(var_1, var_2);
}

function strip_suffix(var_0, var_1) {
  if(var_0.size <= var_1.size) {
    return var_0;
  }

  if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1) {
    return getsubstr(var_0, 0, var_0.size - var_1.size);
  }

  return var_0;
}

function isleft2d(var_0, var_1, var_2) {
  var_3 = (var_0[0], var_0[1], 0);
  var_4 = (var_2[0], var_2[1], 0);
  var_5 = var_4 - var_3;
  var_6 = (var_1[0], var_1[1], 0);
  return var_5[0] * var_6[1] - var_5[1] * var_6[0] < 0;
}

function vectortoanglessafe(var_0, var_1) {
  var_2 = vectorcross(var_0, var_1);
  var_1 = vectorcross(var_2, var_0);
  var_3 = axistoangles(var_0, var_2, var_1);
  return var_3;
}

function heap(var_0) {
  var_1 = spawnStruct();
  var_1.nvals = 0;
  var_1.vals = [];

  if(var_0 == "max") {
    var_1.swap = &_heaplessthan;
  } else if(var_0 == "min") {
    var_1.swap = &_heapgreaterthan;
  }

  return var_1;
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
    var_0 = self.vals[1];
    self.vals[1] = undefined;
    self.nvals = 0;
    return var_0;
  }

  var_0 = self.vals[1];
  self.vals[1] = self.vals[self.nvals];
  self.vals[self.nvals] = undefined;
  _heapify(1);
  self.nvals -= 1;
  return var_0;
}

function heapinsert(var_0) {
  self.vals[self.nvals + 1] = var_0;
  var_1 = self.nvals + 1;
  var_2 = _heapparent(var_1);

  while(isDefined(var_2)) {
    if([[self.swap]](var_2, var_1)) {
      var_3 = self.vals[var_2];
      self.vals[var_2] = self.vals[var_1];
      self.vals[var_1] = var_3;
      var_1 = var_2;
      var_2 = _heapparent(var_1);
      continue;
    }

    break;
  }

  self.nvals += 1;
}

function printheap() {
  var_0 = [];
  var_1 = self.nvals;

  for(var_2 = 0; var_2 < var_1; var_2++) {
    var_0 = heappop();
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    heapinsert(var_0[var_2]);
  }

  for(var_2 = 0; var_2 < var_0.size; var_2++) {}
}

function _heapgreaterthan(var_0, var_1) {
  return self.vals[var_0] > self.vals[var_1];
}

function _heaplessthan(var_0, var_1) {
  return self.vals[var_0] < self.vals[var_1];
}

function _heapify(var_0) {
  var_1 = _heapleftchild(var_0);
  var_2 = _heaprightchild(var_0);
  var_3 = undefined;
  var_4 = 0;

  if(isDefined(var_1)) {
    var_4 = self[[self.swap]](var_0, var_1);
  }

  var_5 = 0;

  if(isDefined(var_2)) {
    var_5 = self[[self.swap]](var_0, var_2);
  }

  if(!var_4 && !var_5) {
    return;
  } else if(var_4 && !var_5) {
    var_3 = var_1;
  } else if(!var_4 && var_5) {
    var_3 = var_2;
  } else if(self[[self.swap]](var_1, var_2)) {
    var_3 = var_2;
  } else {
    var_3 = var_1;
  }

  var_6 = self.vals[var_0];
  self.vals[var_0] = self.vals[var_3];
  self.vals[var_3] = var_6;
  _heapify(var_3);
}

function _heapleftchild(var_0) {
  if(!isDefined(self.vals[2 * var_0])) {
    return undefined;
  }

  return 2 * var_0;
}

function _heaprightchild(var_0) {
  if(!isDefined(self.vals[2 * var_0 + 1])) {
    return undefined;
  }

  return 2 * var_0 + 1;
}

function _heapparent(var_0) {
  if(var_0 == 1) {
    return undefined;
  }

  return int(floor(var_0 / 2));
}

function isnumbermultipleof(var_0, var_1) {
  return var_0 > 0 && var_0 % var_1 == 0;
}

function laststand_dogtags(var_0) {
  var_1 = var_0 == undefined;
}