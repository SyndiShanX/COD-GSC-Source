/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7fc58c95ee47d870.gsc
***********************************************/

_id_69B64F047B0AF1DB(radius) {
  event = _id_0D74AE0B4AA21186::_id_C74368899713E7E6();
  event.radius = radius;
  event._id_8FA87D2C8780E014 = radius * radius;
  event.result = [];
  _id_3C91684198954C83 = self._id_3C59090EE220AB3D._id_3C91684198954C83;
  _id_3C91684198954C83._id_61C0BF2E5D0B72D1 = event;
  _id_3C91684198954C83.events[_id_3C91684198954C83.events.size] = event;

  if(!isDefined(level._id_3C59090EE220AB3D.events._id_CCE0BDB14AD78AF5)) {
    result = [];

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < getlootspawnscriptableindexfirst(); _id_AC0E594AC96AA3A8++) {
      _id_DB376EE90688810D = getscriptableinstancefromindex(_id_AC0E594AC96AA3A8);

      if(!isDefined(_id_DB376EE90688810D)) {
        continue;
      }
      if(_id_DB376EE90688810D.type == "military_ammo_restock") {
        _id_FE8F7703F6313ED4 = result.size;
        result[_id_FE8F7703F6313ED4] = spawnStruct();
        result[_id_FE8F7703F6313ED4].entity = _id_DB376EE90688810D;
        result[_id_FE8F7703F6313ED4].type = "ammo_restock";
      }
    }

    level._id_3C59090EE220AB3D.events._id_CCE0BDB14AD78AF5 = result;
  }
}

_id_7E7DDFA33EFF2C11() {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_61C0BF2E5D0B72D1;

  if(!event._id_D0942E9D2044D6C6) {
    if(event.result.size > 0)
      event.result = [];

    foreach(_id_D7043241CAEEA644 in level._id_3C59090EE220AB3D.events._id_CCE0BDB14AD78AF5) {
      if(distancesquared(_id_D7043241CAEEA644.entity.origin, self.origin) < event._id_8FA87D2C8780E014)
        event.result[event.result.size] = _id_D7043241CAEEA644;
    }

    event._id_D0942E9D2044D6C6 = 1;
  }

  return event.result;
}