/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5adad3b6e57811aa.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14);
}

_id_E0844A2B7F904B14(bot) {
  _id_72BB89E60D3674DF = 0;
  target = undefined;
  _id_FDF6F26ABEE82B42 = bot _id_2D121AC0A4E1A5B8::_id_7E7DDFA33EFF2C11();
  _id_FDF6F26ABEE82B42 _id_2D121AC0A4E1A5B8::_id_2F1735D1CB737A0C(bot);
  _id_FDF6F26ABEE82B42 _id_2D121AC0A4E1A5B8::_id_8500E6AE452B1E19(self._id_E889B543C8E054AE._id_93102C55F2858271);

  foreach(player in _id_FDF6F26ABEE82B42.result) {
    _id_DF8E0358F6E2B842 = distance(bot.origin, player.origin);

    if(_id_DF8E0358F6E2B842 <= 1) {
      continue;
    }
    score = 0;
    basescore = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_DF8E0358F6E2B842, self._id_E889B543C8E054AE._id_96AF88C97DB9ED21, self._id_E889B543C8E054AE._id_49E2976CA0C853EF);

    if(bot _id_59FF79D681BB860C::_id_3569A4BEC8B9AF17(player))
      score = basescore + self._id_E889B543C8E054AE._id_ED9B346626F27A7F;
    else if(bot botcanseeentity(player))
      score = basescore;
    else if(_id_DF8E0358F6E2B842 < self._id_E889B543C8E054AE._id_5DCBC5CCEC64F7DE) {
      _id_C2C14DDFADA133F3 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_DF8E0358F6E2B842, self._id_E889B543C8E054AE._id_E3D1CF896F26EE33, self._id_E889B543C8E054AE._id_85A0650F30C0B0B9);
      score = basescore + _id_C2C14DDFADA133F3;
    }

    if(score > _id_72BB89E60D3674DF) {
      _id_72BB89E60D3674DF = score;
      target = player;
    }
  }

  if(isDefined(target))
    self._id_DF9D35D9B4BEE654 = _id_54A9E44119886147::_id_E3D9D27A30E4D693(target);

  return _id_72BB89E60D3674DF;
}