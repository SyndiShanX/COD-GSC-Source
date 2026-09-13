/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_22594d942a4f2fa9.gsc
***********************************************/

_id_69B64F047B0AF1DB(radius, duration) {
  event = _id_0D74AE0B4AA21186::_id_C74368899713E7E6();
  event._id_8FA87D2C8780E014 = radius * radius;
  event.duration = duration;
  event.result = [];
  _id_3C91684198954C83 = self._id_3C59090EE220AB3D._id_3C91684198954C83;
  _id_3C91684198954C83._id_B726268175E85134 = event;
  _id_3C91684198954C83.events[_id_3C91684198954C83.events.size] = event;
}

_id_7E7DDFA33EFF2C11() {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_B726268175E85134;

  if(!event._id_D0942E9D2044D6C6) {
    if(event.result.size > 0) {
      foreach(entnum, _id_855EB1686E661658 in event.result) {
        _id_23818FD0489C7005 = _id_3EEAF0541F4883FE(_id_855EB1686E661658.time, _id_855EB1686E661658.origin);

        if(_id_23818FD0489C7005)
          event.result[entnum] = undefined;
      }
    }

    foreach(player in level.players) {
      _id_887D42B1410C39FE = !isDefined(player) || self.team == player.team;

      if(_id_887D42B1410C39FE) {
        continue;
      }
      _id_B4C04337A6A90C84 = self lastknowntime(player);
      _id_23C058E984C5A869 = self lastknownpos(player);
      _id_DFC26E2288AB07CB = _id_B4C04337A6A90C84 <= 0;
      _id_B9F15FE7C92886C0 = !isvector(_id_23C058E984C5A869);
      entitynumber = player getentitynumber();
      _id_7712019717126CB1 = _id_DFC26E2288AB07CB || _id_B9F15FE7C92886C0 || _id_3EEAF0541F4883FE(_id_B4C04337A6A90C84, _id_23C058E984C5A869);

      if(_id_7712019717126CB1) {
        if(isDefined(event.result[entitynumber]))
          event.result[entitynumber] = undefined;

        continue;
      }

      _id_F90358454413407F = event.result[entitynumber];

      if(!isDefined(_id_F90358454413407F)) {
        _id_F90358454413407F = spawnStruct();
        _id_F90358454413407F.entnum = entitynumber;
        _id_F90358454413407F._id_05956C54E54EBF3D = 1;
        _id_F90358454413407F.time = _id_B4C04337A6A90C84;
        _id_F90358454413407F.origin = _id_23C058E984C5A869;
        event.result[entitynumber] = _id_F90358454413407F;
        continue;
      }

      if(_id_B4C04337A6A90C84 != _id_F90358454413407F.time) {
        _id_F90358454413407F._id_05956C54E54EBF3D = 1;
        _id_F90358454413407F.time = _id_B4C04337A6A90C84;
        _id_F90358454413407F.origin = _id_23C058E984C5A869;
      }
    }

    event._id_D0942E9D2044D6C6 = 1;
  }

  return event.result;
}

_id_0FBB2D5E09E58DB7() {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_B726268175E85134;
  return event.duration;
}

_id_6ECF7023EF123BA0(entitynumber) {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_B726268175E85134;
  _id_F90358454413407F = event.result[entitynumber];

  if(isDefined(_id_F90358454413407F))
    _id_F90358454413407F._id_05956C54E54EBF3D = 0;
}

_id_3EEAF0541F4883FE(time, position) {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_B726268175E85134;
  return (gettime() - time) / 1000 > event.duration || distancesquared(self.origin, position) > event._id_8FA87D2C8780E014;
}