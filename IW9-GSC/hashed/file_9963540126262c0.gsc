/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_9963540126262c0.gsc
***********************************************/

_id_69B64F047B0AF1DB(radius) {
  event = _id_0D74AE0B4AA21186::_id_C74368899713E7E6();
  event.radius = radius;
  event._id_8FA87D2C8780E014 = radius * radius;
  event.result = [];
  _id_3C91684198954C83 = self._id_3C59090EE220AB3D._id_3C91684198954C83;
  _id_3C91684198954C83._id_C821041CE9F4100B = event;
  _id_3C91684198954C83.events[_id_3C91684198954C83.events.size] = event;

  if(!isDefined(level._id_3C59090EE220AB3D.events._id_5B25E7620E424CB2))
    level thread _id_F1F01B106BB7BD95();
}

_id_F1F01B106BB7BD95() {
  level endon("game_ended");
  level._id_3C59090EE220AB3D.events._id_5B25E7620E424CB2 = [];

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && !istrue(level.skipprematch))
    level waittill("prematch_cleanup");

  result = [];
  _id_B252AFB1C6D8213C = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "br_plunder_box");

  foreach(_id_E4A6D0A55FD775A7 in _id_B252AFB1C6D8213C) {
    if(istrue(_id_E4A6D0A55FD775A7.visible))
      result[result.size] = _id_E4A6D0A55FD775A7;
  }

  level._id_3C59090EE220AB3D.events._id_5B25E7620E424CB2 = result;
}

_id_7E7DDFA33EFF2C11() {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_C821041CE9F4100B;

  if(!event._id_D0942E9D2044D6C6) {
    if(event.result.size > 0)
      event.result = [];

    foreach(_id_E4A6D0A55FD775A7 in level._id_3C59090EE220AB3D.events._id_5B25E7620E424CB2) {
      if(distancesquared(_id_E4A6D0A55FD775A7.origin, self.origin) <= event._id_8FA87D2C8780E014)
        event.result[event.result.size] = _id_E4A6D0A55FD775A7;
    }

    event._id_D0942E9D2044D6C6 = 1;
  }

  return event.result;
}