/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\arbitrary_up.gsc
***********************************************/

initarbitraryuptriggers() {
  if(isDefined(level.arbitraryuptriggers)) {
    return;
  }
  level.arbitraryuptriggers = [];
  level.arbitraryuptriggersstructs = [];

  if(scripts\cp_mp\utility\game_utility::getmapname() == "_encstr_8147082D8A3F48F84548") {
    var_0 = getEntArray("_encstr_8AC70715BB40A957BF", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

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
        var_4.base = getEnt(var_2.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
        var_4.blinkloc = var_4.base.origin + (0, 0, -175);
      }

      level.arbitraryuptriggersstructs[var_3] = var_4;
      thread watcharbitraryuptriggerenter(var_4);
      thread watcharbitraryuptriggerexit(var_4);
    }
  }
}

watcharbitraryuptriggerenter(var_0) {
  for(;;) {
    var_0.trigger waittill("_encstr_8F5C086405E70FBA4B4A", var_1);

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

watcharbitraryuptriggerexit(var_0) {
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

      if(isDefined(var_2.arbitraryuptriggerstruct) && var_2.arbitraryuptriggerstruct == var_0)
        var_2.arbitraryuptriggerstruct = undefined;
    }

    waitframe();
  }
}

shouldaddtoarbitraryuptrigger(var_0, var_1) {
  if(!isPlayer(var_1))
    return 0;

  var_2 = var_1 getentitynumber();

  if(isDefined(var_0.entsinside[var_2]))
    return 0;

  return 1;
}

shouldremovefromarbitraryuptrigger(var_0, var_1) {
  if(!var_1 istouching(var_0.trigger))
    return 1;

  return 0;
}

getarbitraryuptrigger() {
  if(!isDefined(self.arbitraryuptriggerstruct))
    return undefined;

  return self.arbitraryuptriggerstruct.trigger;
}

getarbitraryuptriggerbase() {
  if(!isDefined(self.arbitraryuptriggerstruct))
    return undefined;

  return self.arbitraryuptriggerstruct.base;
}

getarbitraryuptriggerblinkloc() {
  if(!isDefined(self.arbitraryuptriggerstruct))
    return undefined;

  return self.arbitraryuptriggerstruct.blinkloc;
}

isinarbitraryup() {
  if(isPlayer(self)) {
    if(self getworldupreferenceangles() != (0, 0, 0))
      return 1;
  }

  return 0;
}