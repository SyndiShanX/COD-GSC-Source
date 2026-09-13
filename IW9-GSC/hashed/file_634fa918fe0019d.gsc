/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_634fa918fe0019d.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14);
}

_id_E0844A2B7F904B14(bot) {
  _id_72BB89E60D3674DF = 0;
  target = undefined;
  _id_C6E1584BB0AD0B20 = scripts\cp_mp\utility\game_utility::_id_3BF9723F3DDB4D76();
  _id_83A23165FD04447A = 0;

  if(_id_C6E1584BB0AD0B20)
    _id_83A23165FD04447A = !bot _id_2CEDCC356F1B9FC8::_id_F5446040A93792C3();

  _id_FDF6F26ABEE82B42 = bot _id_2D121AC0A4E1A5B8::_id_7E7DDFA33EFF2C11();
  _id_FDF6F26ABEE82B42 _id_2D121AC0A4E1A5B8::_id_2F1735D1CB737A0C(bot);
  _id_FDF6F26ABEE82B42 _id_2D121AC0A4E1A5B8::_id_8500E6AE452B1E19(self._id_E889B543C8E054AE._id_93102C55F2858271);
  _id_1147BBC93EA9B83C = scripts\mp\gamelogic::_id_1147BBC93EA9B83C();
  _id_5C8FD7FE25F207B5 = 0;
  _id_66B33F71B3567EF3 = 0;

  if(_id_FDF6F26ABEE82B42.result.size > 0) {
    _id_4246CA4ED25D36CA = _id_40E63DD222434655::_id_1C51F7C46A848DDD();
    _id_66B33F71B3567EF3 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_4246CA4ED25D36CA, self._id_E889B543C8E054AE._id_E23500DBD314BAE2, self._id_E889B543C8E054AE._id_58E441D166562D6E);
    _id_5C8FD7FE25F207B5 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_4246CA4ED25D36CA, self._id_E889B543C8E054AE._id_E23500DBD314BAE2, self._id_E889B543C8E054AE._id_54EE9450D37B6312);
  }

  foreach(player in _id_FDF6F26ABEE82B42.result) {
    if(distance(bot.origin, player.origin) <= 1) {
      continue;
    }
    if(!bot _id_59FF79D681BB860C::_id_42266A7FD7932C50(player)) {
      continue;
    }
    score = 0;
    _id_DF8E0358F6E2B842 = distance(bot.origin, player.origin);
    basescore = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_DF8E0358F6E2B842, self._id_E889B543C8E054AE._id_96AF88C97DB9ED21, self._id_E889B543C8E054AE._id_49E2976CA0C853EF);

    if(_id_1147BBC93EA9B83C) {
      score = basescore;

      if(bot _id_59FF79D681BB860C::_id_3569A4BEC8B9AF17(player))
        score = score + self._id_E889B543C8E054AE._id_ED9B346626F27A7F;
    } else if(bot _id_59FF79D681BB860C::_id_3569A4BEC8B9AF17(player))
      score = basescore + _id_66B33F71B3567EF3 + self._id_E889B543C8E054AE._id_ED9B346626F27A7F;
    else if(bot botcanseeentity(player))
      score = basescore + _id_66B33F71B3567EF3;
    else if(isbot(player) && _id_DF8E0358F6E2B842 < self._id_E889B543C8E054AE._id_DFDFB13389358AEE && !player _id_4C9BD9A3BF3F8CF7::_id_6F6C5CB39CD095B0()) {
      _id_C2C14DDFADA133F3 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_DF8E0358F6E2B842, self._id_E889B543C8E054AE._id_E3D1CF896F26EE33, self._id_E889B543C8E054AE._id_85A0650F30C0B0B9);
      score = basescore + _id_66B33F71B3567EF3 + _id_C2C14DDFADA133F3;
    } else if(_id_DF8E0358F6E2B842 < self._id_E889B543C8E054AE._id_893C20B0DBF4A9CA) {
      _id_C2C14DDFADA133F3 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_DF8E0358F6E2B842, self._id_E889B543C8E054AE._id_E3D1CF896F26EE33, self._id_E889B543C8E054AE._id_85A0650F30C0B0B9);
      score = basescore + _id_5C8FD7FE25F207B5 + _id_C2C14DDFADA133F3;
    } else if(_id_699BB9F5414B2149(bot, player)) {
      _id_C2C14DDFADA133F3 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_DF8E0358F6E2B842, self._id_E889B543C8E054AE._id_E3D1CF896F26EE33, self._id_E889B543C8E054AE._id_85A0650F30C0B0B9);
      score = basescore + _id_66B33F71B3567EF3 + _id_C2C14DDFADA133F3;
      score = score * self._id_E889B543C8E054AE._id_D066ABBF0BC74501;
    } else if(!isbot(player)) {
      if(istrue(player._id_E54CC9323D3DC44E) && isDefined(self._id_E889B543C8E054AE._id_891066F3BC70EDCB)) {
        _id_DF2E5586F7D31F26 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_DF8E0358F6E2B842, self._id_E889B543C8E054AE._id_891066F3BC70EDCB, self._id_E889B543C8E054AE._id_55BF1EEC1BFDDF31);
        score = basescore + _id_DF2E5586F7D31F26;
      }

      if(isDefined(level.br_circle) && isDefined(level.br_circle._id_5B8569581E64D55A) && !istrue(player._id_E54CC9323D3DC44E)) {
        _id_F9C2D49EEF2BD3E2 = (gettime() - level.br_circle._id_5B8569581E64D55A) / 1000;
        _id_3C1EDA8DB07EC036 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_F9C2D49EEF2BD3E2, self._id_E889B543C8E054AE._id_0115B29B18485DE3, self._id_E889B543C8E054AE._id_631E50E6EC9A24A8);

        if(player.kills < _id_3C1EDA8DB07EC036)
          score = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_DF8E0358F6E2B842, self._id_E889B543C8E054AE._id_036D2E5E6B1E19A3, self._id_E889B543C8E054AE._id_F1FF9682C42F2749);
      }
    }

    if(istrue(player.inlaststand))
      score = score + self._id_E889B543C8E054AE._id_A05ACA4DAA9A3D42;

    if(_id_C6E1584BB0AD0B20) {
      if(_id_83A23165FD04447A && player _id_2CEDCC356F1B9FC8::_id_F5446040A93792C3())
        score = score + _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_DF8E0358F6E2B842, self._id_E889B543C8E054AE._id_EE504D1D9BE98BF3, self._id_E889B543C8E054AE._id_069898B04F2AFF79);
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

_id_699BB9F5414B2149(bot, player) {
  bots = scripts\mp\utility\teams::getteamdata(bot.team, "alivePlayers");

  foreach(_id_F0EA4030349A33D5 in bots) {
    if(_id_F0EA4030349A33D5 == bot || !_id_59FF79D681BB860C::isvalidplayer(_id_F0EA4030349A33D5)) {
      continue;
    }
    if(isDefined(_id_F0EA4030349A33D5._id_9B84CED9D9596292) && _id_F0EA4030349A33D5._id_9B84CED9D9596292 == player)
      return 1;
  }

  return 0;
}