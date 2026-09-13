/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\scriptable_group.gsc
***********************************************/

_id_200BD098377A8674(_id_335FED1E2375FFB0, _id_449DA622A6FE97BD, _id_9137B8627FDF4CC8) {
  if(!isDefined(level._id_C51387D07AF317B7))
    level._id_C51387D07AF317B7 = [];

  group = spawnStruct();
  group.scriptables = [];
  group._id_EE94B5848A8F3159 = 0;
  group._id_7680C3DC0438706E = 0;
  group.max_count = _id_449DA622A6FE97BD;
  group._id_35B0B2E8BEE60AF4 = _id_9137B8627FDF4CC8;
  level._id_C51387D07AF317B7[_id_335FED1E2375FFB0] = group;
}

_id_F8ECD6E02634E682(_id_335FED1E2375FFB0) {
  if(isDefined(level._id_C51387D07AF317B7) && isDefined(level._id_C51387D07AF317B7[_id_335FED1E2375FFB0])) {
    group = level._id_C51387D07AF317B7[_id_335FED1E2375FFB0];
    return group.scriptables;
  }

  return undefined;
}

_id_476B3BEECD82DCCA(_id_335FED1E2375FFB0, instance) {
  if(!isDefined(level._id_C51387D07AF317B7) || !isDefined(level._id_C51387D07AF317B7[_id_335FED1E2375FFB0])) {
    return;
  }
  group = level._id_C51387D07AF317B7[_id_335FED1E2375FFB0];
  _id_3E036CF2BD9BF933(group);
  instance._id_4A0145502132790A = group._id_7680C3DC0438706E;
  group.scriptables[instance._id_4A0145502132790A] = instance;
  group._id_7680C3DC0438706E++;
}

_id_879CCB6A53E634F5(_id_335FED1E2375FFB0, instance) {
  if(!isDefined(level._id_C51387D07AF317B7[_id_335FED1E2375FFB0])) {
    return;
  }
  group = level._id_C51387D07AF317B7[_id_335FED1E2375FFB0];
  group.scriptables[instance._id_4A0145502132790A] = undefined;
  instance._id_4A0145502132790A = undefined;
}

_id_3E036CF2BD9BF933(group) {
  if(group.scriptables.size < group.max_count) {
    return;
  }
  _id_D89DFB4BD556862A = 0;

  for(id = group._id_EE94B5848A8F3159; id < group._id_7680C3DC0438706E; id++) {
    if(_id_D89DFB4BD556862A == group._id_35B0B2E8BEE60AF4) {
      break;
    }

    instance = group.scriptables[id];

    if(isDefined(instance)) {
      if(isent(instance))
        instance delete();
      else {
        instance notify("death");
        instance freescriptable();
      }

      _id_D89DFB4BD556862A++;
    }

    group.scriptables[id] = undefined;
    group._id_EE94B5848A8F3159++;
  }
}