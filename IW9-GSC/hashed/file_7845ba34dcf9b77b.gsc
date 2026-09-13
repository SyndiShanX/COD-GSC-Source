/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_7845ba34dcf9b77b.gsc
***********************************************/

_id_69B64F047B0AF1DB() {
  event = _id_0D74AE0B4AA21186::_id_C74368899713E7E6();
  event.result = [];
  _id_3C91684198954C83 = self._id_3C59090EE220AB3D._id_3C91684198954C83;
  _id_3C91684198954C83._id_D338B2CC0965FDB3 = event;
  _id_3C91684198954C83.events[_id_3C91684198954C83.events.size] = event;
}

_id_7E7DDFA33EFF2C11() {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_D338B2CC0965FDB3;

  if(!event._id_D0942E9D2044D6C6) {
    if(event.result.size > 0)
      event.result = [];

    if(!isDefined(level.allfobs))
      return event.result;

    foreach(fob in level.allfobs) {
      _id_B9100D06B4FCEC73 = fob.trigger.gameobject;

      if(!_id_B9100D06B4FCEC73 scripts\mp\gameobjects::caninteractwith(self.team)) {
        continue;
      }
      event.result[event.result.size] = fob;
    }

    event._id_D0942E9D2044D6C6 = 1;
  }

  return event.result;
}