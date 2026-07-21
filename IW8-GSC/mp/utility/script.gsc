/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\utility\script.gsc
***********************************************/

waittillslowprocessallowed(var_0) {
  if(level.lastslowprocessframe == gettime()) {
    if(isDefined(var_0) && var_0) {
      while(level.lastslowprocessframe == gettime())
        wait 0.05;
    } else {
      wait 0.05;

      if(level.lastslowprocessframe == gettime()) {
        wait 0.05;

        if(level.lastslowprocessframe == gettime()) {
          wait 0.05;

          if(level.lastslowprocessframe == gettime())
            wait 0.05;
        }
      }
    }
  }

  level.lastslowprocessframe = gettime();
}

queuecreate(var_0) {
  if(!isDefined(level.queues))
    level.queues = [];

  level.queues[var_0] = [];
}

queueadd(var_0, var_1) {
  level.queues[var_0][level.queues[var_0].size] = var_1;
}

queueremovefirst(var_0) {
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

    var_2[var_2.size] = var_4;
  }

  level.queues[var_0] = var_2;
  return var_1;
}

quicksort(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = ::juggernaut_dmg_modifier;

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
      for(var_3++; var_2 < var_3; var_2 = var_2 + 1) {
        var_6 = var_0[var_2];

        for(var_7 = var_2 - 1; var_7 >= 0 && [[var_1]](var_6, var_0[var_7]); var_7 = var_7 - 1)
          var_0[var_7 + 1] = var_0[var_7];

        var_0[var_7 + 1] = var_6;
      }

      continue;
    }

    var_6 = var_0[var_3];
    var_8 = var_2 - 1;

    for(var_7 = var_2; var_7 <= var_3 - 1; var_7++) {
      if([[var_1]](var_0[var_7], var_6)) {
        var_8++;
        var_9 = var_0[var_8];
        var_0[var_8] = var_0[var_7];
        var_0[var_7] = var_9;
      }
    }

    var_8++;
    var_9 = var_0[var_8];
    var_0[var_8] = var_0[var_3];
    var_0[var_3] = var_9;

    if(var_8 - 1 > var_2) {
      var_5++;
      var_4[var_5] = var_2;
      var_5++;
      var_4[var_5] = var_8 - 1;
    }

    if(var_8 + 1 < var_3) {
      var_5++;
      var_4[var_5] = var_8 + 1;
      var_5++;
      var_4[var_5] = var_3;
    }
  }

  return var_0;
}

juggernaut_dmg_modifier(var_0, var_1) {
  return var_0 <= var_1;
}

limitdecimalplaces(var_0, var_1) {
  var_2 = 1;

  for(var_3 = 0; var_3 < var_1; var_3++)
    var_2 = var_2 * 10;

  var_4 = var_0 * var_2;
  var_4 = int(var_4);
  var_4 = var_4 / var_2;
  return var_4;
}

rounddecimalplaces(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = "_encstr_8EC3082B5B3FABED18F3";

  var_3 = 1;

  for(var_4 = 0; var_4 < var_1; var_4++)
    var_3 = var_3 * 10;

  var_5 = var_0 * var_3;

  if(var_2 == "_encstr_87070365F7")
    var_6 = ceil(var_5);
  else if(var_2 == "_encstr_9767056D0FBFA8")
    var_6 = floor(var_5);
  else
    var_6 = var_5 + 0.5;

  var_5 = int(var_6);
  var_5 = var_5 / var_3;
  return var_5;
}

stringtofloat(var_0) {
  var_1 = strtok(var_0, "_encstr_BD4C024E");
  var_2 = int(var_1[0]);

  if(isDefined(var_1[1])) {
    var_3 = 1;

    for(var_4 = 0; var_4 < var_1[1].size; var_4++)
      var_3 = var_3 * 0.1;

    var_2 = var_2 + int(var_1[1]) * var_3;
  }

  return var_2;
}

isstrstart(var_0, var_1) {
  return getsubstr(var_0, 0, var_1.size) == var_1;
}

array_remove_keep_index(var_0, var_1) {
  var_2 = [];

  foreach(var_5, var_4 in var_0) {
    if(var_4 != var_1)
      var_2[var_5] = var_4;
  }

  return var_2;
}

delayentdelete(var_0) {
  self endon("_encstr_AD75063D571AE108");
  wait(var_0);

  if(isDefined(self))
    self delete();
}

roundup(var_0) {
  if(var_0 - int(var_0) >= 0.5)
    return int(var_0 + 1);
  else
    return int(var_0);
}

bufferednotify(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  thread bufferednotify_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);
}

bufferednotify_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_9 = "_encstr_A1AE10653D1FA4D9AB499BDB72A041E9417F" + var_0;
  self notify(var_9);
  self endon(var_9);

  if(!isDefined(self.bufferednotifications))
    self.bufferednotifications = [];

  if(!isDefined(self.bufferednotifications[var_0]))
    self.bufferednotifications[var_0] = [];

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
  waittillframeend;

  while(self.bufferednotifications[var_0].size > 0) {
    var_10 = self.bufferednotifications[var_0][0];
    self notify(var_0, var_10.param1, var_10.param2, var_10.param3, var_10.param4, var_10.param5, var_10.param6, var_10.param7, var_10.param8);
    self.bufferednotifications[var_0] = scripts\engine\utility::array_remove_index(self.bufferednotifications[var_0], 0);
    waitframe();
  }
}

notifyafterframeend(var_0, var_1) {
  self waittill(var_0);
  waittillframeend;
  self notify(var_1);
}

delaysetclientomnvar(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  wait(var_0);
  self setclientomnvar(var_1, var_2);
}

strip_suffix(var_0, var_1) {
  if(var_0.size <= var_1.size)
    return var_0;

  if(getsubstr(var_0, var_0.size - var_1.size, var_0.size) == var_1)
    return getsubstr(var_0, 0, var_0.size - var_1.size);

  return var_0;
}

isleft2d(var_0, var_1, var_2) {
  var_3 = (var_0[0], var_0[1], 0);
  var_4 = (var_2[0], var_2[1], 0);
  var_5 = var_4 - var_3;
  var_6 = (var_1[0], var_1[1], 0);
  return var_5[0] * var_6[1] - var_5[1] * var_6[0] < 0;
}

vectortoanglessafe(var_0, var_1) {
  var_2 = vectorcross(var_0, var_1);
  var_1 = vectorcross(var_2, var_0);
  var_3 = axistoangles(var_0, var_2, var_1);
  return var_3;
}

heap(var_0) {
  var_1 = spawnStruct();
  var_1.nvals = 0;
  var_1.vals = [];

  if(var_0 == "_encstr_B81904B62CC3")
    var_1.swap = ::_heaplessthan;
  else if(var_0 == "_encstr_8719046B4BB9")
    var_1.swap = ::_heapgreaterthan;

  return var_1;
}

heapsize() {
  return self.nvals;
}

heappeek() {
  return self.vals[1];
}

heappop() {
  if(self.nvals == 0)
    return undefined;
  else if(self.nvals == 1) {
    var_0 = self.vals[1];
    self.vals[1] = undefined;
    self.nvals = 0;
    return var_0;
  } else {
    var_0 = self.vals[1];
    self.vals[1] = self.vals[self.nvals];
    self.vals[self.nvals] = undefined;
    _heapify(1);
    self.nvals = self.nvals - 1;
    return var_0;
  }
}

heapinsert(var_0) {
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

  self.nvals = self.nvals + 1;
}

printheap() {
  var_0 = [];
  var_1 = self.nvals;

  for(var_2 = 0; var_2 < var_1; var_2++)
    var_0[var_2] = heappop();

  for(var_2 = 0; var_2 < var_0.size; var_2++)
    heapinsert(var_0[var_2]);

  for(var_2 = 0; var_2 < var_0.size; var_2++) {}
}

_heapgreaterthan(var_0, var_1) {
  return self.vals[var_0] > self.vals[var_1];
}

_heaplessthan(var_0, var_1) {
  return self.vals[var_0] < self.vals[var_1];
}

_heapify(var_0) {
  var_1 = _heapleftchild(var_0);
  var_2 = _heaprightchild(var_0);
  var_3 = undefined;
  var_4 = 0;

  if(isDefined(var_1))
    var_4 = self[[self.swap]](var_0, var_1);

  var_5 = 0;

  if(isDefined(var_2))
    var_5 = self[[self.swap]](var_0, var_2);

  if(!var_4 && !var_5)
    return;
  else if(var_4 && !var_5)
    var_3 = var_1;
  else if(!var_4 && var_5)
    var_3 = var_2;
  else if(self[[self.swap]](var_1, var_2))
    var_3 = var_2;
  else
    var_3 = var_1;

  var_6 = self.vals[var_0];
  self.vals[var_0] = self.vals[var_3];
  self.vals[var_3] = var_6;
  _heapify(var_3);
}

_heapleftchild(var_0) {
  if(!isDefined(self.vals[2 * var_0]))
    return undefined;

  return 2 * var_0;
}

_heaprightchild(var_0) {
  if(!isDefined(self.vals[2 * var_0 + 1]))
    return undefined;

  return 2 * var_0 + 1;
}

_heapparent(var_0) {
  if(var_0 == 1)
    return undefined;

  return int(floor(var_0 / 2));
}

isnumbermultipleof(var_0, var_1) {
  return var_0 > 0 && var_0 % var_1 == 0;
}

laststand_dogtags(var_0) {
  var_1 = var_0 == undefined;
}