/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_47366beb5ba9fa22.gsc
***********************************************/

_id_69B64F047B0AF1DB() {
  event = _id_0D74AE0B4AA21186::_id_C74368899713E7E6();
  event.result = [];
  _id_3C91684198954C83 = self._id_3C59090EE220AB3D._id_3C91684198954C83;
  _id_3C91684198954C83._id_C0F0C13703C22359 = event;
  _id_3C91684198954C83.events[_id_3C91684198954C83.events.size] = event;
}

_id_7E7DDFA33EFF2C11() {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_C0F0C13703C22359;

  if(!event._id_D0942E9D2044D6C6) {
    if(event.result.size > 0)
      event.result = [];

    if(!isDefined(level.objectives))
      return event.result;

    foreach(obj in level.objectives) {
      switch (level.gametype) {
        case "dom":
          if(self.team == obj scripts\mp\gameobjects::getownerteam()) {
            continue;
          }
          break;
        case "koth":
          if(!istrue(obj.active)) {
            continue;
          }
          break;
      }

      event.result[event.result.size] = obj;
    }

    if(event.result.size > 1)
      event.result = scripts\engine\utility::array_sort_with_func(event.result, ::_id_0CB083B117C783AF);

    event._id_D0942E9D2044D6C6 = 1;
  }

  return event.result;
}

_id_0CB083B117C783AF(_id_52283A0A1CF75C1E, _id_5228390A1CF759EB) {
  return distancesquared(_id_52283A0A1CF75C1E.curorigin, self.origin) < distancesquared(_id_5228390A1CF759EB.curorigin, self.origin);
}

_id_B4E30A9548AA351B() {
  _id_10887EF2F24A6C0D = level.prevzoneindex % level.objectives.size + 1;
  return level.objectives[scripts\engine\utility::string(_id_10887EF2F24A6C0D)];
}