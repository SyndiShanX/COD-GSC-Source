/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_150fee7943687302.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14);
}

_id_E0844A2B7F904B14(bot) {
  if(!level.br_armory_kiosk_enabled)
    return -100;

  _id_14F8998B9E6F6BBA = _id_5B0291AEAB99561B(bot);

  if(!isDefined(_id_14F8998B9E6F6BBA))
    return -100;

  _id_72BB89E60D3674DF = _id_14F8998B9E6F6BBA.score;
  target = _id_14F8998B9E6F6BBA.target;
  self._id_DF9D35D9B4BEE654 = _id_3FCC27C3656C46DC::_id_E3D9D27A30E4D693(target);
  return _id_72BB89E60D3674DF;
}

_id_5B0291AEAB99561B(bot) {
  if(!istrue(level.br_plunder_enabled))
    return undefined;

  _id_B252AFB1C6D8213C = bot _id_09963540126262C0::_id_7E7DDFA33EFF2C11();

  if(_id_B252AFB1C6D8213C.size == 0)
    return undefined;

  target = spawnStruct();
  _id_AD2F80C3D8D4E44E = -100;
  _id_EFABC1F8231CC4F9 = undefined;
  _id_343466BBC23688C9 = level._id_6BE7B375EC4A629C[0];

  foreach(_id_CB325DDB4A764623, cost in _id_343466BBC23688C9["items"]) {
    if(bot.plundercount < cost["cost"]) {
      continue;
    }
    _id_17BEC417681D2AF0 = _id_400A728B86054272(bot, _id_CB325DDB4A764623);

    if(!isDefined(_id_17BEC417681D2AF0)) {
      continue;
    }
    if(_id_17BEC417681D2AF0 > _id_AD2F80C3D8D4E44E) {
      _id_AD2F80C3D8D4E44E = _id_17BEC417681D2AF0;
      _id_EFABC1F8231CC4F9 = _id_CB325DDB4A764623;
    }
  }

  if(!isDefined(_id_EFABC1F8231CC4F9))
    return undefined;

  target._id_1657E74C9190D2A2 = _id_4384ABBF498DF6A7::_id_FE176342ED52B44F(_id_EFABC1F8231CC4F9);
  target._id_7148C1A6F25491F8 = "br_item_purchase";
  target.itemname = _id_EFABC1F8231CC4F9;
  _id_0FF4B6D39036010B = bot _id_40E63DD222434655::_id_8A0FA223B19E44F4(_id_B252AFB1C6D8213C, self._id_E889B543C8E054AE._id_EA186A77C016A88D, self._id_E889B543C8E054AE._id_09551C1A2C6F5863, 0, self._id_E889B543C8E054AE._id_93BCC2B99D24433F, self._id_E889B543C8E054AE._id_05107F0B927DAD2B);

  if(!isDefined(_id_0FF4B6D39036010B) || _id_F7DF7EDCFCE4B1F2(_id_0FF4B6D39036010B.target, bot))
    return undefined;

  _id_9073E5955EAEBE2C = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_40E63DD222434655::_id_1C51F7C46A848DDD(), self._id_E889B543C8E054AE._id_E23500DBD314BAE2, self._id_E889B543C8E054AE._id_E58A5E1EFEB78937);
  _id_8AEE78BD838BA612 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(bot.plundercount, self._id_E889B543C8E054AE._id_8E95BDA6C02D6964, self._id_E889B543C8E054AE._id_2A7A0C76F330E72D);
  _id_0FF4B6D39036010B.score = _id_0FF4B6D39036010B.score + _id_9073E5955EAEBE2C;
  _id_0FF4B6D39036010B.score = _id_0FF4B6D39036010B.score + _id_8AEE78BD838BA612;

  if(!_id_40E63DD222434655::ispointincurrentsafecircle(_id_0FF4B6D39036010B.target.origin)) {
    _id_79EEF5A8E34AC410 = _id_2695A20D4011076D::getdangercircleradius() - distance(_id_0FF4B6D39036010B.target.origin, _id_2695A20D4011076D::getdangercircleorigin());
    _id_E2D41D6BE5320861 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_79EEF5A8E34AC410, self._id_E889B543C8E054AE._id_79EEF5A8E34AC410, self._id_E889B543C8E054AE._id_CA580A719E470379);
    _id_0FF4B6D39036010B.score = _id_0FF4B6D39036010B.score + _id_E2D41D6BE5320861;
  }

  target._id_2FA65F34EB9042F5 = _id_0FF4B6D39036010B.target;
  result = spawnStruct();
  result.target = target;
  result.score = _id_AD2F80C3D8D4E44E + _id_0FF4B6D39036010B.score;
  return result;
}

_id_400A728B86054272(bot, _id_BF09A57AF008ACD6) {
  _id_A1093166DE09E6B8 = self._id_E889B543C8E054AE._id_E34F223C4F415ED0[_id_BF09A57AF008ACD6];

  if(isDefined(_id_A1093166DE09E6B8) && bot _id_40E63DD222434655::_id_0BBC2D6967287DC7(_id_A1093166DE09E6B8))
    return self._id_E889B543C8E054AE._id_7D0FD6FF10EDEFD6[_id_BF09A57AF008ACD6];
  else
    return undefined;
}

_id_F7DF7EDCFCE4B1F2(_id_2FA65F34EB9042F5, bot) {
  if(!isDefined(_id_2FA65F34EB9042F5._id_19C6F51451310013))
    return 0;

  _id_3F6F0F4C8E8D9B4C = 15000;
  _id_0ECC808E906F27F3 = _id_2FA65F34EB9042F5._id_19C6F51451310013[bot.entity_number];

  if(!isDefined(_id_0ECC808E906F27F3) || gettime() > _id_0ECC808E906F27F3 + _id_3F6F0F4C8E8D9B4C) {
    _id_2FA65F34EB9042F5._id_19C6F51451310013[bot.entity_number] = undefined;
    return 0;
  }

  return 1;
}