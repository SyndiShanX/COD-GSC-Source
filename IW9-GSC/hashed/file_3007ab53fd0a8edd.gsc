/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3007ab53fd0a8edd.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14);
}

_id_E0844A2B7F904B14(bot) {
  if(!level.br_armory_kiosk_enabled)
    return -100;

  _id_C065D1CA4804EA3A = _id_1B5842B9B6465162(bot);

  if(!isDefined(_id_C065D1CA4804EA3A))
    return -100;

  self._id_DF9D35D9B4BEE654 = _id_3FCC27C3656C46DC::_id_E3D9D27A30E4D693(_id_C065D1CA4804EA3A.target);
  _id_72BB89E60D3674DF = _id_C065D1CA4804EA3A.score * self._id_E889B543C8E054AE._id_2D40425EBDA06605;
  return _id_72BB89E60D3674DF;
}

_id_1B5842B9B6465162(bot) {
  if(!istrue(level.br_plunder_enabled))
    return undefined;

  _id_69590E67F030F9AA = "teamReviver";
  _id_B6736234A4AC9BD1 = isDefined(level._id_6BE7B375EC4A629C[0]["items"][_id_69590E67F030F9AA]);

  if(!_id_B6736234A4AC9BD1)
    return undefined;

  _id_2A70AE11EFAFEA87 = bot.plundercount >= _id_4384ABBF498DF6A7::_id_517B8730DDEC7F59(_id_69590E67F030F9AA);

  if(!_id_2A70AE11EFAFEA87)
    return undefined;

  _id_10A39F1A0B6D2AA2 = _id_26CCBFE3954CACF4::_id_A5786099CA387B00();
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(bot.team, "players");
  _id_38882A650F503344 = undefined;

  foreach(player in _id_6D5ED003AF1F9612) {
    if(!isDefined(player) || player == bot) {
      continue;
    }
    if(player _id_40E63DD222434655::_id_A9CBF557DC66D201()) {
      if(!isai(player)) {
        _id_38882A650F503344 = player;
        break;
      } else if(!isDefined(_id_38882A650F503344) && _id_10A39F1A0B6D2AA2)
        _id_38882A650F503344 = player;
    }
  }

  if(!isDefined(_id_38882A650F503344))
    return undefined;

  _id_B252AFB1C6D8213C = bot _id_09963540126262C0::_id_7E7DDFA33EFF2C11();

  if(_id_B252AFB1C6D8213C.size == 0)
    return undefined;

  _id_0FF4B6D39036010B = bot _id_40E63DD222434655::_id_8A0FA223B19E44F4(_id_B252AFB1C6D8213C, self._id_E889B543C8E054AE._id_87F34CF0D41D251D, self._id_E889B543C8E054AE._id_38A8985512B3E7B3, 0, self._id_E889B543C8E054AE._id_93BCC2B99D24433F, self._id_E889B543C8E054AE._id_05107F0B927DAD2B);

  if(!isDefined(_id_0FF4B6D39036010B) || _id_150FEE7943687302::_id_F7DF7EDCFCE4B1F2(_id_0FF4B6D39036010B.target, bot))
    return undefined;

  if(!_id_40E63DD222434655::ispointincurrentsafecircle(_id_0FF4B6D39036010B.target.origin)) {
    _id_79EEF5A8E34AC410 = _id_2695A20D4011076D::getdangercircleradius() - distance(_id_0FF4B6D39036010B.target.origin, _id_2695A20D4011076D::getdangercircleorigin());
    _id_E2D41D6BE5320861 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_79EEF5A8E34AC410, self._id_E889B543C8E054AE._id_79EEF5A8E34AC410, self._id_E889B543C8E054AE._id_CA580A719E470379);
    _id_0FF4B6D39036010B.score = _id_0FF4B6D39036010B.score + _id_E2D41D6BE5320861;
  }

  target = spawnStruct();
  target._id_1657E74C9190D2A2 = _id_38882A650F503344._id_3F78C6A0862F9E25 + 1;
  target.itemname = bot.name;
  target._id_7148C1A6F25491F8 = "br_team_revive";
  target._id_2FA65F34EB9042F5 = _id_0FF4B6D39036010B.target;
  result = spawnStruct();
  result.target = target;
  result.score = _id_0FF4B6D39036010B.score;
  return result;
}