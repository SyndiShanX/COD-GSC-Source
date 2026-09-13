/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\engine\scriptable_door.gsc
***********************************************/

system_init() {
  if(isDefined(level.scriptable_door_initialized)) {
    return;
  }
  level.scriptable_door_initialized = 1;
}

_id_29BA88E5CE21F3FD(_id_08886A1F80D549ED) {
  level._id_BE09CAD9B5D91063 = _id_08886A1F80D549ED;
}

_id_E37078F3D00EF312(_id_90B8BDA8E925EFA2) {
  level._id_D9A4B8AE6FA68979 = _id_90B8BDA8E925EFA2;
}

_id_87D7BE37D61CBAE3(_id_03CAD3873B0F5153) {
  level.door_unlocked = _id_03CAD3873B0F5153;
}

_id_9F2D576809F96D2E(instance, player) {
  if(isDefined(level._id_BE09CAD9B5D91063))
    return [[level._id_BE09CAD9B5D91063]](instance, player);

  return &"";
}

_id_47A1E5B6A230D71F(instance, player, _id_85E3240D30E184E7) {
  if(isDefined(level._id_D9A4B8AE6FA68979))
    return [[level._id_D9A4B8AE6FA68979]](instance, player, _id_85E3240D30E184E7);

  return 0;
}

_id_7E3B4DE29E022CEA(instance, player) {
  if(isDefined(level.door_unlocked))
    [[level.door_unlocked]](instance, player);
}