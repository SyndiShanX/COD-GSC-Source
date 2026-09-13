/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2d121ac0a4e1a5b8.gsc
***********************************************/

_id_69B64F047B0AF1DB(radius) {
  event = _id_0D74AE0B4AA21186::_id_C74368899713E7E6();
  event.radius = radius;
  event._id_8FA87D2C8780E014 = radius * radius;
  event.result = [];
  _id_3C91684198954C83 = self._id_3C59090EE220AB3D._id_3C91684198954C83;
  _id_3C91684198954C83._id_78122E18403A8DC4 = event;
  _id_3C91684198954C83.events[_id_3C91684198954C83.events.size] = event;
}

_id_7E7DDFA33EFF2C11() {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_78122E18403A8DC4;

  if(!event._id_D0942E9D2044D6C6) {
    if(event.result.size > 0)
      event.result = [];

    foreach(player in level.players) {
      _id_887D42B1410C39FE = !_id_59FF79D681BB860C::_id_DED80385EA7471DB(player) || self == player || player _id_26CCBFE3954CACF4::_id_6ECC7CD453466014() || player _id_2CEDCC356F1B9FC8::isplayerinorgoingtogulag() || distancesquared(self.origin, player.origin) > event._id_8FA87D2C8780E014;

      if(!_id_887D42B1410C39FE)
        event.result[event.result.size] = player;
    }

    if(event.result.size > 1) {
      _id_A1E9948C82AF623D = sortbydistance(event.result, self.origin);

      if(isDefined(_id_A1E9948C82AF623D))
        event.result = _id_A1E9948C82AF623D;
    }

    event.origin = self.origin;
    event._id_D0942E9D2044D6C6 = 1;
  }

  _id_18176E8F61BB2E83 = spawnStruct();
  _id_18176E8F61BB2E83.event = event;
  _id_18176E8F61BB2E83.result = event.result;
  return _id_18176E8F61BB2E83;
}

_id_8500E6AE452B1E19(distance) {
  distsq = squared(distance);
  result = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.result.size; _id_AC0E594AC96AA3A8++) {
    player = self.result[_id_AC0E594AC96AA3A8];

    if(distancesquared(player.origin, self.event.origin) > distsq) {
      break;
    }

    result[result.size] = player;
  }

  self.result = result;
}

_id_11BAF65D33128D66(_id_C4B81997F0120A97, _id_4951C8537D45134F) {
  result = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < self.result.size; _id_AC0E594AC96AA3A8++) {
    player = self.result[_id_AC0E594AC96AA3A8];
    _id_4E2F45F5B1DFD822 = isalliedsentient(_id_C4B81997F0120A97, player);

    if(_id_4951C8537D45134F == _id_4E2F45F5B1DFD822)
      result[result.size] = player;
  }

  self.result = result;
}

_id_2F1735D1CB737A0C(player) {
  _id_11BAF65D33128D66(player, 0);
}

_id_3E53D600C1F31122(player) {
  _id_11BAF65D33128D66(player, 1);
}

_id_5D4DE1BEEEA46131() {
  event = self._id_3C59090EE220AB3D._id_3C91684198954C83._id_78122E18403A8DC4;
  return event.radius;
}