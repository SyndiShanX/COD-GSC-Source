/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\arbitrary_up.gsc
***********************************************/

#using scripts\cp_mp\utility\game_utility;
#namespace arbitrary_up;

function initarbitraryuptriggers() {
  if(isDefined(level.arbitraryuptriggers)) {
    return;
  }

  level.arbitraryuptriggers = [];
  level.arbitraryuptriggersstructs = [];

  if(getmapname() == "mp_junk") {
    arbitraryuptriggers = getEntArray("mag_up", "targetname");

    if(!isDefined(arbitraryuptriggers) || arbitraryuptriggers.size == 0) {
      return;
    }

    level.arbitraryuptriggers = arbitraryuptriggers;

    foreach(trigger in arbitraryuptriggers) {
      entnum = trigger getentitynumber();
      triggerstruct = spawnStruct();
      triggerstruct.trigger = trigger;
      triggerstruct.base = undefined;
      triggerstruct.entsinside = [];

      if(isDefined(trigger.target)) {
        triggerstruct.base = getEnt(trigger.target, "targetname");
        triggerstruct.blinkloc = triggerstruct.base.origin + (0, 0, -175);
      }

      level.arbitraryuptriggersstructs[entnum] = triggerstruct;
      thread watcharbitraryuptriggerenter(triggerstruct);
      thread watcharbitraryuptriggerexit(triggerstruct);
    }
  }
}

function watcharbitraryuptriggerenter(triggerstruct) {
  while(true) {
    triggerstruct.trigger waittill("trigger", ent);

    if(!isDefined(ent)) {
      continue;
    }

    if(!shouldaddtoarbitraryuptrigger(triggerstruct, ent)) {
      continue;
    }

    entnum = ent getentitynumber();
    triggerstruct.entsinside[entnum] = ent;
    ent.arbitraryuptriggerstruct = triggerstruct;
  }
}

function watcharbitraryuptriggerexit(triggerstruct) {
  while(true) {
    foreach(ent in triggerstruct.entsinside) {
      if(!isDefined(ent)) {
        continue;
      }

      if(!shouldremovefromarbitraryuptrigger(triggerstruct, ent)) {
        continue;
      }

      entnum = ent getentitynumber();
      triggerstruct.entsinside[entnum] = undefined;

      if(isDefined(ent.arbitraryuptriggerstruct) && ent.arbitraryuptriggerstruct == triggerstruct) {
        ent.arbitraryuptriggerstruct = undefined;
      }
    }

    waitframe();
  }
}

function shouldaddtoarbitraryuptrigger(triggerstruct, ent) {
  if(!isPlayer(ent)) {
    return false;
  }

  entnum = ent getentitynumber();

  if(isDefined(triggerstruct.entsinside[entnum])) {
    return false;
  }

  return true;
}

function shouldremovefromarbitraryuptrigger(triggerstruct, ent) {
  if(!ent istouching(triggerstruct.trigger)) {
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