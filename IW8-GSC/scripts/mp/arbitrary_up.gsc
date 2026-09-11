/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\arbitrary_up.gsc
***********************************************/

function initarbitraryuptriggers() {
  if(isDefined(level.arbitraryuptriggers)) {
    return;
  }

  level.arbitraryuptriggers = [];
  level.arbitraryuptriggersstructs = [];

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_junk") {
    var0 = getEntArray("mag_up", "targetname");

    if(!isDefined(var0) || var0.size == 0) {
      return;
    }

    level.arbitraryuptriggers = var0;

    foreach(var2 in var0) {
      var3 = var2 getentitynumber();
      var4 = spawnStruct();
      var4.trigger = var2;
      var4.base = undefined;
      var4.entsinside = [];

      if(isDefined(var2.target)) {
        var4.base = getEnt(var2.target, "targetname");
        var4.blinkloc = var4.base.origin + (0, 0, -175);
      }

      level.arbitraryuptriggersstructs[var3] = var4;
      thread watcharbitraryuptriggerenter(var4);
      thread watcharbitraryuptriggerexit(var4);
    }

    return;
  }
}

function watcharbitraryuptriggerenter(var0) {
  for(;;) {
    var0.trigger waittill("trigger", var1);

    if(!isDefined(var1)) {
      continue;
    }

    if(!shouldaddtoarbitraryuptrigger(var0, var1)) {
      continue;
    }

    var2 = var1 getentitynumber();
    var0.entsinside[var2] = var1;
    var1.arbitraryuptriggerstruct = var0;
  }
}

function watcharbitraryuptriggerexit(var0) {
  for(;;) {
    foreach(var2 in var0.entsinside) {
      if(!isDefined(var2)) {
        continue;
      }

      if(!shouldremovefromarbitraryuptrigger(var0, var2)) {
        continue;
      }

      var3 = var2 getentitynumber();
      var0.entsinside[var3] = undefined;

      if(isDefined(var2.arbitraryuptriggerstruct) && var2.arbitraryuptriggerstruct == var0) {
        var2.arbitraryuptriggerstruct = undefined;
      }
    }

    waitframe();
  }
}

function shouldaddtoarbitraryuptrigger(var0, var1) {
  if(!isPlayer(var1)) {
    return false;
  }

  var2 = var1 getentitynumber();

  if(isDefined(var0.entsinside[var2])) {
    return false;
  }

  return true;
}

function shouldremovefromarbitraryuptrigger(var0, var1) {
  if(!var1 istouching(var0.trigger)) {
    return true;
  }

  return false;
}

function getarbitraryuptrigger() {
  if(!isDefined(self.arbitraryuptriggerstruct)) {
    return undefined;
  }

  return self.arbitraryuptriggerstruct.trigger;
}

function getarbitraryuptriggerbase() {
  if(!isDefined(self.arbitraryuptriggerstruct)) {
    return undefined;
  }

  return self.arbitraryuptriggerstruct.base;
}

function getarbitraryuptriggerblinkloc() {
  if(!isDefined(self.arbitraryuptriggerstruct)) {
    return undefined;
  }

  return self.arbitraryuptriggerstruct.blinkloc;
}

function isinarbitraryup() {
  if(isPlayer(self)) {
    if(self getworldupreferenceangles() != (0, 0, 0)) {
      return true;
    }
  }

  return false;
}