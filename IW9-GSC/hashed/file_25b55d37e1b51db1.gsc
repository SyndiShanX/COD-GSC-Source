/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_25b55d37e1b51db1.gsc
***********************************************/

_id_69B64F047B0AF1DB(_id_325752CB29127EEB) {
  event = _id_0D74AE0B4AA21186::_id_C74368899713E7E6();
  event._id_325752CB29127EEB = _id_325752CB29127EEB;
  event.list = [];

  if(!isDefined(level._id_3C59090EE220AB3D.events._id_CBD599CC41B2A3F1)) {
    _id_2A96D0EA58C991BE = [];
    _id_2A96D0EA58C991BE[0] = "footstep";
    _id_2A96D0EA58C991BE[1] = "footstep_walk";
    _id_2A96D0EA58C991BE[2] = "footstep_sprint";
    _id_2A96D0EA58C991BE[5] = "death";
    _id_2A96D0EA58C991BE[9] = "gunshot";
    _id_2A96D0EA58C991BE[12] = "silenced_shot";
    _id_2A96D0EA58C991BE[14] = "bullet_whizby";
    _id_2A96D0EA58C991BE[15] = "projectile_impact";
    _id_2A96D0EA58C991BE[31] = "can_see";
    _id_2A96D0EA58C991BE[32] = "radar";
    level._id_3C59090EE220AB3D.events._id_CBD599CC41B2A3F1 = _id_2A96D0EA58C991BE;
  }

  _id_3C91684198954C83 = self._id_3C59090EE220AB3D._id_3C91684198954C83;
  _id_3C91684198954C83._id_0083F7C458A67D43 = event;
  _id_3C91684198954C83.events[_id_3C91684198954C83.events.size] = event;
  thread _id_712ABDDB7195A3EE();
}

_id_712ABDDB7195A3EE() {
  level endon("game_ended");
  self endon("death");
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_0083F7C458A67D43;

  for(;;) {
    self waittill("known_event", _id_BD73C7ACC56CD20C, eventtype, time, pos);

    if(isDefined(level._id_3C59090EE220AB3D.events._id_CBD599CC41B2A3F1[eventtype]) && isDefined(_id_BD73C7ACC56CD20C) && isDefined(eventtype) && isDefined(time) && isDefined(pos) && _id_CD5F5785B43F138F(eventtype, pos)) {
      _id_0CBFCBD7B8D7CBB0 = spawnStruct();
      _id_0CBFCBD7B8D7CBB0.owner = _id_BD73C7ACC56CD20C;
      _id_0CBFCBD7B8D7CBB0.time = time;
      _id_0CBFCBD7B8D7CBB0.pos = pos;
      _id_0CBFCBD7B8D7CBB0.type = level._id_3C59090EE220AB3D.events._id_CBD599CC41B2A3F1[eventtype];
      event.list[event.list.size] = _id_0CBFCBD7B8D7CBB0;
    }
  }
}

_id_7E7DDFA33EFF2C11() {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_0083F7C458A67D43;

  if(!event._id_D0942E9D2044D6C6) {
    _id_379A32677FB69595 = gettime() - event._id_325752CB29127EEB;
    index = undefined;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < event.list.size; _id_AC0E594AC96AA3A8++) {
      if(event.list[_id_AC0E594AC96AA3A8].time > _id_379A32677FB69595) {
        break;
      }

      index = _id_AC0E594AC96AA3A8;
    }

    if(isDefined(index)) {
      _id_502CA8F7BC239543 = [];

      for(_id_AC0E594AC96AA3A8 = index + 1; _id_AC0E594AC96AA3A8 < event.list.size; _id_AC0E594AC96AA3A8++)
        _id_502CA8F7BC239543[_id_502CA8F7BC239543.size] = event.list[_id_AC0E594AC96AA3A8];

      event.list = _id_502CA8F7BC239543;
    }

    event._id_D0942E9D2044D6C6 = 1;
  }

  return event.list;
}

_id_CD5F5785B43F138F(eventtype, pos) {
  if(eventtype != 32)
    return 1;

  _id_0548581E373C57CE = 600;
  return distance2dsquared(self.origin, pos) <= squared(_id_0548581E373C57CE);
}