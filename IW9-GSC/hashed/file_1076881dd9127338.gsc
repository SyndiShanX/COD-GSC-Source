/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1076881dd9127338.gsc
***********************************************/

_id_69B64F047B0AF1DB(radius) {
  event = _id_0D74AE0B4AA21186::_id_C74368899713E7E6();
  event._id_8FA87D2C8780E014 = radius * radius;
  event.result = [];
  _id_3C91684198954C83 = self._id_3C59090EE220AB3D._id_3C91684198954C83;
  _id_3C91684198954C83._id_9B7E812B9D289BBF = event;
  _id_3C91684198954C83.events[_id_3C91684198954C83.events.size] = event;

  if(!isDefined(level._id_3C59090EE220AB3D.events._id_39DAE4A0E7EE4D47))
    level._id_3C59090EE220AB3D.events._id_39DAE4A0E7EE4D47 = [];
}

_id_7E7DDFA33EFF2C11() {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_9B7E812B9D289BBF;

  if(!event._id_D0942E9D2044D6C6) {
    if(event.result.size > 0)
      event.result = [];

    groups = scripts\engine\utility::getStructArray("bot_camp_group", "script_noteworthy");

    foreach(group in groups) {
      if(distancesquared(group.origin, self.origin) > event._id_8FA87D2C8780E014) {
        continue;
      }
      if(_id_5A45D11A570A19C5(group)) {
        continue;
      }
      event.result[event.result.size] = group;
    }

    event._id_D0942E9D2044D6C6 = 1;
  }

  return event.result;
}

_id_5A45D11A570A19C5(_id_200C8F755E8F626B) {
  _id_4D163D658AC0C416 = level._id_3C59090EE220AB3D.events._id_39DAE4A0E7EE4D47[_id_200C8F755E8F626B.target];

  if(!isDefined(_id_4D163D658AC0C416))
    return 0;

  _id_4A681D08B83B6920 = _id_4D163D658AC0C416[self.team];

  if(!isDefined(_id_4A681D08B83B6920))
    return 0;

  return _id_4A681D08B83B6920 != self.entity_number;
}

_id_7DBE596500A2E27C(_id_200C8F755E8F626B) {
  if(!isDefined(level._id_3C59090EE220AB3D.events._id_39DAE4A0E7EE4D47[_id_200C8F755E8F626B.target]))
    level._id_3C59090EE220AB3D.events._id_39DAE4A0E7EE4D47[_id_200C8F755E8F626B.target] = [];

  level._id_3C59090EE220AB3D.events._id_39DAE4A0E7EE4D47[_id_200C8F755E8F626B.target][self.team] = self.entity_number;
}

_id_5F6E68B080316FCF(_id_200C8F755E8F626B) {
  _id_4D163D658AC0C416 = level._id_3C59090EE220AB3D.events._id_39DAE4A0E7EE4D47[_id_200C8F755E8F626B.target];

  if(!isDefined(_id_4D163D658AC0C416)) {
    return;
  }
  _id_4A681D08B83B6920 = _id_4D163D658AC0C416[self.team];

  if(isDefined(_id_4A681D08B83B6920) && _id_4A681D08B83B6920 == self.entity_number)
    level._id_3C59090EE220AB3D.events._id_39DAE4A0E7EE4D47[_id_200C8F755E8F626B.target][self.team] = undefined;
}