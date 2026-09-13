/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\arbitrary_up.gsc
***********************************************/

initarbitraryuptriggers() {
  if(isDefined(level.arbitraryuptriggers)) {
    return;
  }
  level.arbitraryuptriggers = [];
  level.arbitraryuptriggersstructs = [];

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_junk") {
    arbitraryuptriggers = getEntArray("mag_up", "targetname");

    if(!isDefined(arbitraryuptriggers) || arbitraryuptriggers.size == 0) {
      return;
    }
    level.arbitraryuptriggers = arbitraryuptriggers;

    foreach(trigger in arbitraryuptriggers) {
      entnum = trigger getentitynumber();
      _id_633ED0D009B54036 = spawnStruct();
      _id_633ED0D009B54036.trigger = trigger;
      _id_633ED0D009B54036.base = undefined;
      _id_633ED0D009B54036.entsinside = [];

      if(isDefined(trigger.target)) {
        _id_633ED0D009B54036.base = getEnt(trigger.target, "targetname");
        _id_633ED0D009B54036.blinkloc = _id_633ED0D009B54036.base.origin + (0, 0, -175);
      }

      level.arbitraryuptriggersstructs[entnum] = _id_633ED0D009B54036;
      thread watcharbitraryuptriggerenter(_id_633ED0D009B54036);
      thread watcharbitraryuptriggerexit(_id_633ED0D009B54036);
    }
  }
}

watcharbitraryuptriggerenter(_id_633ED0D009B54036) {
  for(;;) {
    _id_633ED0D009B54036.trigger waittill("trigger", ent);

    if(!isDefined(ent)) {
      continue;
    }
    if(!shouldaddtoarbitraryuptrigger(_id_633ED0D009B54036, ent)) {
      continue;
    }
    entnum = ent getentitynumber();
    _id_633ED0D009B54036.entsinside[entnum] = ent;
    ent.arbitraryuptriggerstruct = _id_633ED0D009B54036;
  }
}

watcharbitraryuptriggerexit(_id_633ED0D009B54036) {
  for(;;) {
    foreach(ent in _id_633ED0D009B54036.entsinside) {
      if(!isDefined(ent)) {
        continue;
      }
      if(!shouldremovefromarbitraryuptrigger(_id_633ED0D009B54036, ent)) {
        continue;
      }
      entnum = ent getentitynumber();
      _id_633ED0D009B54036.entsinside[entnum] = undefined;

      if(isDefined(ent.arbitraryuptriggerstruct) && ent.arbitraryuptriggerstruct == _id_633ED0D009B54036)
        ent.arbitraryuptriggerstruct = undefined;
    }

    waitframe();
  }
}

shouldaddtoarbitraryuptrigger(_id_633ED0D009B54036, ent) {
  if(!isPlayer(ent))
    return 0;

  entnum = ent getentitynumber();

  if(isDefined(_id_633ED0D009B54036.entsinside[entnum]))
    return 0;

  return 1;
}

shouldremovefromarbitraryuptrigger(_id_633ED0D009B54036, ent) {
  if(!ent istouching(_id_633ED0D009B54036.trigger))
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