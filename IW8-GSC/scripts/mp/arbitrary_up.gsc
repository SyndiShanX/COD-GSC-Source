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
    var_0 = getEntArray("mag_up", "targetname");

    if(!isDefined(var_0) || var_0.size == 0) {
      return;
    }

    level.arbitraryuptriggers = var_0;

    foreach(var_2 in var_0) {
      var_3 = var_2 getentitynumber();
      var_4 = spawnStruct();
      var_4.trigger = var_2;
      var_4.base = undefined;
      var_4.entsinside = [];

      if(isDefined(var_2.target)) {
        var_4.base = getEnt(var_2.target, "targetname");
        var_4.blinkloc = var_4.base.origin + (0, 0, -175);
      }

      level.arbitraryuptriggersstructs[var_3] = var_4;
      thread watcharbitraryuptriggerenter(var_4);
      thread watcharbitraryuptriggerexit(var_4);
    }

    return;
  }
}

function watcharbitraryuptriggerenter(var_0) {
  for(;;) {
    var_0.trigger waittill("trigger", var_1);

    if(!isDefined(var_1)) {
      continue;
    }

    if(!shouldaddtoarbitraryuptrigger(var_0, var_1)) {
      continue;
    }

    var_2 = var_1 getentitynumber();
    var_0.entsinside[var_2] = var_1;
    var_1.arbitraryuptriggerstruct = var_0;
  }
}

function watcharbitraryuptriggerexit(var_0) {
  for(;;) {
    foreach(var_2 in var_0.entsinside) {
      if(!isDefined(var_2)) {
        continue;
      }

      if(!shouldremovefromarbitraryuptrigger(var_0, var_2)) {
        continue;
      }

      var_3 = var_2 getentitynumber();
      var_0.entsinside[var_3] = undefined;

      if(isDefined(var_2.arbitraryuptriggerstruct) && var_2.arbitraryuptriggerstruct == var_0) {
        var_2.arbitraryuptriggerstruct = undefined;
      }
    }

    waitframe();
  }
}

function shouldaddtoarbitraryuptrigger(var_0, var_1) {
  if(!isPlayer(var_1)) {
    return false;
  }

  var_2 = var_1 getentitynumber();

  if(isDefined(var_0.entsinside[var_2])) {
    return false;
  }

  return true;
}

function shouldremovefromarbitraryuptrigger(var_0, var_1) {
  if(!var_1 istouching(var_0.trigger)) {
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