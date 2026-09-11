/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\mp\melee.gsc
***********************************************/

function waittillslowprocessallowed(var0) {
  if(level.lastslowprocessframe == gettime()) {
    if(isDefined(var0) && var0) {
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

function queuecreate(var0) {
  if(!isDefined(level.queues)) {
    level.queues = [];
  }

  level.queues[var0] = [];
}

function queueadd(var0, var1) {
  level.queues[var0][level.queues[var0].size] = var1;
}

function queueremovefirst(var0) {
  var1 = undefined;
  var2 = [];

  foreach(var4 in level.queues[var0]) {
    if(!isDefined(var4)) {
      continue;
    }

    if(!isDefined(var1)) {
      var1 = var4;
      continue;
    }

    var2 = var4;
  }

  level.queues[var0] = var2;
  return var1;
}

function quicksort(var0, var1) {
  return quicksortmid(var0, 0, var0.size - 1, var1);
}

function quicksortmid(var0, var1, var2, var3) {
  var4 = var1;
  var5 = var2;

  if(!isDefined(var3)) {
    var3 = &quicksort_compare;
  }

  if(var2 - var1 >= 1) {
    var6 = var0[var1];

    while(var5 > var4) {
      while([[var3]](var0[var4], var6) && var4 <= var2 && var5 > var4) {
        var4++;
      }

      while(![[var3]](var0[var5], var6) && var5 >= var1 && var5 >= var4) {
        var5--;
      }

      if(var5 > var4) {
        var0 = swap(var0, var4, var5);
      }
    }

    var0 = swap(var0, var1, var5);
    var0 = quicksortmid(var0, var1, var5 - 1, var3);
    var0 = quicksortmid(var0, var5 + 1, var2, var3);
  } else {
    return var1;
  }

  return var0;
}

function quicksort_compare(var0, var1) {
  return var0 <= var1;
}

function swap(var0, var1, var2) {
  var3 = var0[var1];
  var0 = var0[var2];
  var0 = var3;
  return var0;
}

function limitdecimalplaces(var0, var1) {
  var2 = 1;

  for(var3 = 0; var3 < var1; var3++) {
    var2 *= 10;
  }

  var4 = var0 * var2;
  var4 = int(var4);
  var4 /= var2;
  return var4;
}

function rounddecimalplaces(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = "nearest";
  }

  var3 = 1;

  for(var4 = 0; var4 < var1; var4++) {
    var3 *= 10;
  }

  var5 = var0 * var3;

  if(var2 == "up") {
    var6 = ceil(var5);
  } else if(var3 == "down") {
    var6 = floor(var6);
  } else {
    var6 += 0.5;
  }

  var6 = int(var6);
  var6 /= var5;
  return var6;
}

function stringtofloat(var0) {
  var1 = strtok(var0, ".");
  var2 = int(var1[0]);

  if(isDefined(var1[1])) {
    var3 = 1;

    for(var4 = 0; var4 < var1[1].size; var4++) {
      var3 *= 0.1;
    }

    var2 += int(var1[1]) * var3;
  }

  return var2;
}

function isstrstart(var0, var1) {
  return getsubstr(var0, 0, var1.size) == var1;
}

function array_remove_keep_index(var0, var1) {
  var2 = [];

  foreach(var4 in var0) {
    if(var4 != var1) {
      var2 = var4;
    }
  }

  return var2;
}

function delayentdelete(var0) {
  self endon("death");
  wait var0;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function roundup(var0) {
  if(var0 - int(var0) >= 0.5) {
    return int(var0 + 1);
  }

  return int(var0);
}

function bufferednotify(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  thread bufferednotify_internal(var0, var1, var2, var3, var4, var5, var6, var7, var8);
}

function bufferednotify_internal(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  self endon("disconnect");
  level endon("game_ended");
  var9 = "bufferedNotify_" + var0;
  self notify(var9);
  self endon(var9);

  if(!isDefined(self.bufferednotifications)) {
    self.bufferednotifications = [];
  }

  if(!isDefined(self.bufferednotifications[var0])) {
    self.bufferednotifications[var0] = [];
  }

  var10 = spawnStruct();
  var10.param1 = var1;
  var10.param2 = var2;
  var10.param3 = var3;
  var10.param4 = var4;
  var10.param5 = var5;
  var10.param6 = var6;
  var10.param7 = var7;
  var10.param8 = var8;
  self.bufferednotifications[var0][self.bufferednotifications[var0].size] = var10;
  waittillframeend();

  while(self.bufferednotifications[var0].size > 0) {
    var10 = self.bufferednotifications[var0][0];
    self notify(var0, var10.param1, var10.param2, var10.param3, var10.param4, var10.param5, var10.param6, var10.param7, var10.param8);
    self.bufferednotifications[var0] = scripts\engine\utility::array_remove_index(self.bufferednotifications[var0], 0);
    waitframe();
  }
}

function notifyafterframeend(var0, var1) {
  self waittill(var0);
  waittillframeend();
  self notify(var1);
}

function delaysetclientomnvar(var0, var1, var2) {
  self endon("disconnect");
  wait var0;
  self setclientomnvar(var1, var2);
}

function strip_suffix(var0, var1) {
  if(var0.size <= var1.size) {
    return var0;
  }

  if(getsubstr(var0, var0.size - var1.size, var0.size) == var1) {
    return getsubstr(var0, 0, var0.size - var1.size);
  }

  return var0;
}

function isleft2d(var0, var1, var2) {
  var3 = (var0[0], var0[1], 0);
  var4 = (var2[0], var2[1], 0);
  var5 = var4 - var3;
  var6 = (var1[0], var1[1], 0);
  return var5[0] * var6[1] - var5[1] * var6[0] < 0;
}

function vectortoanglessafe(var0, var1) {
  var2 = vectorcross(var0, var1);
  var1 = vectorcross(var2, var0);
  var3 = axistoangles(var0, var2, var1);
  return var3;
}

function heap(var0) {
  var1 = spawnStruct();
  var1.nvals = 0;
  var1.vals = [];

  if(var0 == "max") {
    var1.swap = &_heaplessthan;
  } else if(var0 == "min") {
    var1.swap = &_heapgreaterthan;
  }

  return var1;
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
    var0 = self.vals[1];
    self.vals[1] = undefined;
    self.nvals = 0;
    return var0;
  }

  var0 = self.vals[1];
  self.vals[1] = self.vals[self.nvals];
  self.vals[self.nvals] = undefined;
  _heapify(1);
  self.nvals -= 1;
  return var0;
}

function heapinsert(var0) {
  self.vals[self.nvals + 1] = var0;
  var1 = self.nvals + 1;
  var2 = _heapparent(var1);

  while(isDefined(var2)) {
    if([[self.swap]](var2, var1)) {
      var3 = self.vals[var2];
      self.vals[var2] = self.vals[var1];
      self.vals[var1] = var3;
      var1 = var2;
      var2 = _heapparent(var1);
      continue;
    }

    break;
  }

  self.nvals += 1;
}

function printheap() {
  var0 = [];
  var1 = self.nvals;

  for(var2 = 0; var2 < var1; var2++) {
    var0 = heappop();
  }

  for(var2 = 0; var2 < var0.size; var2++) {
    heapinsert(var0[var2]);
  }

  for(var2 = 0; var2 < var0.size; var2++) {}
}

function _heapgreaterthan(var0, var1) {
  return self.vals[var0] > self.vals[var1];
}

function _heaplessthan(var0, var1) {
  return self.vals[var0] < self.vals[var1];
}

function _heapify(var0) {
  var1 = _heapleftchild(var0);
  var2 = _heaprightchild(var0);
  var3 = undefined;
  var4 = 0;

  if(isDefined(var1)) {
    var4 = self[[self.swap]](var0, var1);
  }

  var5 = 0;

  if(isDefined(var2)) {
    var5 = self[[self.swap]](var0, var2);
  }

  if(!var4 && !var5) {
    return;
  } else if(var4 && !var5) {
    var3 = var1;
  } else if(!var4 && var5) {
    var3 = var2;
  } else if(self[[self.swap]](var1, var2)) {
    var3 = var2;
  } else {
    var3 = var1;
  }

  var6 = self.vals[var0];
  self.vals[var0] = self.vals[var3];
  self.vals[var3] = var6;
  _heapify(var3);
}

function _heapleftchild(var0) {
  if(!isDefined(self.vals[2 * var0])) {
    return undefined;
  }

  return 2 * var0;
}

function _heaprightchild(var0) {
  if(!isDefined(self.vals[2 * var0 + 1])) {
    return undefined;
  }

  return 2 * var0 + 1;
}

function _heapparent(var0) {
  if(var0 == 1) {
    return undefined;
  }

  return int(floor(var0 / 2));
}

function isnumbermultipleof(var0, var1) {
  return var0 > 0 && var0 % var1 == 0;
}