/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_1e222fe3807b7bbc.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14, ::_id_E3D9D27A30E4D693, 2000);
}

_id_E0844A2B7F904B14(bot) {
  _id_72BB89E60D3674DF = self._id_E889B543C8E054AE.basescore;

  if(isDefined(level._id_3C59090EE220AB3D.callbacks._id_BCA4B4BDAB5B2718))
    return _id_72BB89E60D3674DF;

  master = bot _id_2810B62E37A684F9();

  if(isDefined(master) && master != bot) {
    if(self._id_E889B543C8E054AE._id_BF4B19A689DBA773 > 0) {
      self._id_DF9D35D9B4BEE654 = _id_0F51749CEF5C1EEC(master);
      _id_90C7BA59A2555B5D = _id_59FF79D681BB860C::_id_9D1AB012058221BB(distance(bot.origin, master.origin), self._id_E889B543C8E054AE._id_B248E7805FBAF822, self._id_E889B543C8E054AE._id_0375A77FD02B3FCC);
      _id_90C7BA59A2555B5D = _id_90C7BA59A2555B5D * self._id_E889B543C8E054AE._id_BF4B19A689DBA773;
      _id_72BB89E60D3674DF = _id_72BB89E60D3674DF + _id_90C7BA59A2555B5D;
    }
  }

  return _id_72BB89E60D3674DF;
}

_id_E3D9D27A30E4D693(bot) {
  return _id_0F51749CEF5C1EEC(undefined);
}

_id_0F51749CEF5C1EEC(_id_0DE5AD618378DCA3) {
  return _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("wander", _id_0DE5AD618378DCA3, "main", "", ::_id_35671B7B1A04BF58, self);
}

_id_35671B7B1A04BF58(bot) {
  _id_E24929C0E254D7B4 = bot _id_188DE758CB607FA3(self._id_A0185A724941F02F, self._id_EC02147FEE952CE2);

  if(!isDefined(_id_E24929C0E254D7B4))
    return "No destination";

  bot _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_E24929C0E254D7B4, self._id_A0185A724941F02F._id_E889B543C8E054AE._id_A135E495FBF4CF96);
  result = bot scripts\engine\utility::waittill_any_in_array_or_timeout(["goal", "bad_path", "long_path"], 15);

  if(result == "goal") {
    if(scripts\mp\utility\game::getsubgametype() != "rumble_mgl") {
      _id_5F50D68561839648 = randomfloatrange(1, 3);
      wait(_id_5F50D68561839648);
    }
  } else if(result == "bad_path" && isDefined(self._id_A0185A724941F02F._id_288CA57E94982F37)) {
    _id_8C9D8551140041F7 = bot._id_3C59090EE220AB3D._id_F0A8822DCC782C9D._id_577F45571C039A54["Pickup"];

    if(isDefined(_id_8C9D8551140041F7))
      _id_8C9D8551140041F7 _id_7C79573F6D201A19::_id_02D9FCD6970321BA(self._id_A0185A724941F02F._id_288CA57E94982F37);
  }

  bot notify("dormant_bot_suspending_chance");

  if(result != "goal" && result != "timeout")
    return result;
}

_id_188DE758CB607FA3(_id_A0185A724941F02F, _id_0DE5AD618378DCA3) {
  if(isDefined(level._id_3C59090EE220AB3D.callbacks._id_BCA4B4BDAB5B2718))
    return self[[level._id_3C59090EE220AB3D.callbacks._id_BCA4B4BDAB5B2718]]();

  _id_288CA57E94982F37 = _id_A0185A724941F02F._id_288CA57E94982F37;
  _id_A0185A724941F02F._id_288CA57E94982F37 = undefined;

  if(isDefined(_id_0DE5AD618378DCA3))
    return _id_75328D9AF88F8B4E(_id_0DE5AD618378DCA3, _id_A0185A724941F02F);
  else if(_id_26CCBFE3954CACF4::_id_D012729EAC1E7053())
    return _id_9E2F5DC882037389(_id_A0185A724941F02F, _id_288CA57E94982F37);
  else
    return _id_D635A657FA4EBF17();
}

_id_75328D9AF88F8B4E(master, _id_A0185A724941F02F) {
  center = undefined;

  if(isbot(master) && master bothasscriptgoal())
    center = master botgetscriptgoal();
  else
    center = master.origin;

  return _id_94DF2AA132008FCC(center, _id_A0185A724941F02F._id_E889B543C8E054AE._id_0CC9B7EF91FC151B, _id_A0185A724941F02F._id_E889B543C8E054AE._id_3145D7ADAFC61293);
}

_id_9E2F5DC882037389(_id_A0185A724941F02F, _id_288CA57E94982F37) {
  _id_8F60E685E9ADA1D8 = 0.5;

  if(randomfloat(1) < _id_8F60E685E9ADA1D8) {
    _id_8C9D8551140041F7 = self._id_3C59090EE220AB3D._id_F0A8822DCC782C9D._id_577F45571C039A54["Pickup"];

    if(isDefined(_id_8C9D8551140041F7)) {
      _id_A0185A724941F02F._id_288CA57E94982F37 = _id_8C9D8551140041F7 _id_7C79573F6D201A19::_id_54F633F649764EA9(self, _id_288CA57E94982F37);

      if(isDefined(_id_A0185A724941F02F._id_288CA57E94982F37))
        return _id_A0185A724941F02F._id_288CA57E94982F37.entity.origin;
    }
  }

  return _id_D635A657FA4EBF17();
}

_id_D635A657FA4EBF17() {
  _id_58A4F0B1D349D24E = 2500;
  return _id_94DF2AA132008FCC(self.origin, _id_58A4F0B1D349D24E, 5);
}

_id_2810B62E37A684F9() {
  if(!_id_58BE75C518BF0D40::issquadmode())
    return undefined;

  squad = level.squaddata[self.team][self._id_0FF97225579DE16A];
  _id_8B0BFB7310CE9582 = _id_87102F4AD2CC5188(self, squad._id_D6EE3E704C6731D4);

  if(_id_8B0BFB7310CE9582 && !isai(squad._id_D6EE3E704C6731D4))
    return squad._id_D6EE3E704C6731D4;

  _id_A5F822B72CE13F72 = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < squad.players.size; _id_AC0E594AC96AA3A8++) {
    player = squad.players[_id_AC0E594AC96AA3A8];

    if(isDefined(squad._id_D6EE3E704C6731D4) && squad._id_D6EE3E704C6731D4 == player) {
      continue;
    }
    if(_id_87102F4AD2CC5188(self, player)) {
      if(!isai(player))
        return player;

      if(!isDefined(_id_A5F822B72CE13F72))
        _id_A5F822B72CE13F72 = player;
    }
  }

  if(_id_8B0BFB7310CE9582)
    return squad._id_D6EE3E704C6731D4;

  return _id_A5F822B72CE13F72;
}

_id_87102F4AD2CC5188(_id_F5CCB6C745FF8F0B, target) {
  return _id_40E63DD222434655::_id_056FB6EEA7E566A2(target);
}

_id_94DF2AA132008FCC(center, distance, _id_CC748B6D457627FE) {
  if(!isDefined(distance))
    distance = 750;

  timeout = gettime() + 1000 * _id_CC748B6D457627FE;

  while(gettime() < timeout) {
    point = _id_59FF79D681BB860C::_id_FCC75AF6225B896B(center, distance, 0.6, 1);
    _id_03863887FED6F155 = _id_59FF79D681BB860C::_id_207BA502560FA1D2(point);

    if(_id_7E816FA0720D38A1::ispointincurrentcircle(_id_03863887FED6F155))
      return _id_03863887FED6F155;

    wait 0.05;
  }

  return _id_9F3FCEA74BCC7C36();
}

_id_9F3FCEA74BCC7C36() {
  _id_819EDACDACB810E4 = _id_2695A20D4011076D::getdangercircleorigin();
  dist = level.br_level.br_circleradii[level.br_circle.circleindex + 1];
  _id_7CB320786D438CCB = _id_59FF79D681BB860C::_id_FCC75AF6225B896B(_id_819EDACDACB810E4, dist);
  return _id_59FF79D681BB860C::_id_207BA502560FA1D2(_id_7CB320786D438CCB);
}

_id_E08EE6939EBFDB4D(func) {
  level._id_3C59090EE220AB3D.callbacks._id_BCA4B4BDAB5B2718 = func;
}