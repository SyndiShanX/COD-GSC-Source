/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4f76bee355450e6d.gsc
***********************************************/

_id_69B64F047B0AF1DB(_id_68BB2DE3CC200341, _id_3A842702009F7B21, _id_AC5CD1591B80858C, _id_5DE4F98AE7344556, _id_6DB2247925C2B26D, _id_866F6164C6AF9DAD) {
  event = _id_0D74AE0B4AA21186::_id_C74368899713E7E6();
  event._id_68BB2DE3CC200341 = _id_68BB2DE3CC200341;
  event._id_6F78DDA98EF53F62 = _id_68BB2DE3CC200341 * _id_68BB2DE3CC200341;
  event._id_3A842702009F7B21 = _id_3A842702009F7B21;
  event._id_AC5CD1591B80858C = _id_AC5CD1591B80858C;
  event._id_F6355CDDB69C209D = _id_AC5CD1591B80858C * _id_AC5CD1591B80858C;
  event._id_5DE4F98AE7344556 = _id_5DE4F98AE7344556;
  event._id_6DB2247925C2B26D = _id_6DB2247925C2B26D;
  event._id_E74DAAB0A4853D7E = _id_6DB2247925C2B26D * _id_6DB2247925C2B26D;
  event._id_866F6164C6AF9DAD = _id_866F6164C6AF9DAD;
  event.result = [];
  _id_3C91684198954C83 = self._id_3C59090EE220AB3D._id_3C91684198954C83;
  _id_3C91684198954C83._id_A8D1793197306629 = event;
  _id_3C91684198954C83.events[_id_3C91684198954C83.events.size] = event;

  if(!isDefined(level._id_3C59090EE220AB3D.events._id_7603E82423679FC0)) {
    _id_EB018172D4FEC728 = [];
    _id_06CAD4DC90CF3C50 = [];

    foreach(itemname, itemtype in level.br_pickups.br_itemtype) {
      if(itemtype == "tablet") {
        _id_EB018172D4FEC728[_id_EB018172D4FEC728.size] = itemname;
        continue;
      }

      if(itemtype == "cache")
        _id_06CAD4DC90CF3C50[_id_06CAD4DC90CF3C50.size] = itemname;
    }

    level._id_3C59090EE220AB3D.events._id_7603E82423679FC0 = spawnStruct();
    level._id_3C59090EE220AB3D.events._id_7603E82423679FC0._id_EB018172D4FEC728 = _id_EB018172D4FEC728;
    level._id_3C59090EE220AB3D.events._id_7603E82423679FC0._id_06CAD4DC90CF3C50 = _id_06CAD4DC90CF3C50;
  }
}

_id_7E7DDFA33EFF2C11() {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_A8D1793197306629;

  if(!event._id_D0942E9D2044D6C6) {
    if(event.result.size > 0)
      event.result = [];

    _id_D416963635DBEDFD(event, self.origin, event._id_68BB2DE3CC200341, event._id_3A842702009F7B21, undefined, ::_id_DC0241948A20B580);
    _id_D416963635DBEDFD(event, self.origin, event._id_AC5CD1591B80858C, event._id_5DE4F98AE7344556, level._id_3C59090EE220AB3D.events._id_7603E82423679FC0._id_06CAD4DC90CF3C50);

    if(level._id_3C59090EE220AB3D.events._id_7603E82423679FC0._id_EB018172D4FEC728.size > 0)
      _id_D416963635DBEDFD(event, self.origin, event._id_6DB2247925C2B26D, event._id_866F6164C6AF9DAD, level._id_3C59090EE220AB3D.events._id_7603E82423679FC0._id_EB018172D4FEC728);

    event._id_D0942E9D2044D6C6 = 1;
  }

  return event.result;
}

_id_D416963635DBEDFD(event, _id_DDF4DD8AD690D592, radius, num, _id_AD4D0CF3E8C9C2A6, _id_BBF1092520E9F019) {
  _id_7603E82423679FC0 = getlootscriptablearrayinradius(_id_AD4D0CF3E8C9C2A6, undefined, _id_DDF4DD8AD690D592, radius);
  _id_A0D21FDD38F60ECF = event.result.size;

  foreach(loot in _id_7603E82423679FC0) {
    if(event.result.size - _id_A0D21FDD38F60ECF >= num) {
      break;
    }

    if(!isDefined(loot.model) || isDefined(loot.itemsdropped)) {
      continue;
    }
    if(isDefined(_id_BBF1092520E9F019) && ![[_id_BBF1092520E9F019]](loot)) {
      continue;
    }
    _id_5577636292591C8B = level.br_pickups.br_itemtype[loot.type];
    _id_FE8F7703F6313ED4 = event.result.size;
    event.result[_id_FE8F7703F6313ED4] = spawnStruct();
    event.result[_id_FE8F7703F6313ED4].entity = loot;
    event.result[_id_FE8F7703F6313ED4].type = _id_5577636292591C8B;
  }
}

_id_DC0241948A20B580(loot) {
  _id_5577636292591C8B = level.br_pickups.br_itemtype[loot.type];

  if(!isDefined(_id_5577636292591C8B))
    return 0;

  if(_id_5577636292591C8B == "cache" || _id_5577636292591C8B == "tablet")
    return 0;

  return 1;
}