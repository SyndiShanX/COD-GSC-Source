/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_167e09f10d782e78.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14);
}

_id_E0844A2B7F904B14(bot) {
  _id_72BB89E60D3674DF = -100;
  target = undefined;
  _id_3A689E7B1E721C9D = bot _id_22594D942A4F2FA9::_id_7E7DDFA33EFF2C11();

  foreach(entnum, _id_855EB1686E661658 in _id_3A689E7B1E721C9D) {
    if(!_id_855EB1686E661658._id_05956C54E54EBF3D) {
      continue;
    }
    if(!_id_7E816FA0720D38A1::ispointincurrentcircle(_id_855EB1686E661658.origin)) {
      continue;
    }
    dist = distance(_id_855EB1686E661658.origin, bot.origin);
    score = _id_59FF79D681BB860C::_id_9D1AB012058221BB(dist, self._id_E889B543C8E054AE._id_96AF88C97DB9ED21, self._id_E889B543C8E054AE._id_7D7F72DF5616D9E8);
    time = gettime() - _id_855EB1686E661658.time;
    score = score + _id_59FF79D681BB860C::_id_9D1AB012058221BB(time, self._id_E889B543C8E054AE._id_D114BA8784FCAB24, self._id_E889B543C8E054AE._id_BF755758AE9AB4ED);

    if(score > _id_72BB89E60D3674DF) {
      target = _id_855EB1686E661658;
      _id_72BB89E60D3674DF = score;
    }
  }

  if(!isDefined(target))
    return _id_72BB89E60D3674DF;

  self._id_DF9D35D9B4BEE654 = _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("Search Threat", target, "main", "$e" + target.entnum, ::_id_35671B7B1A04BF58, self);
  return _id_72BB89E60D3674DF;
}

_id_35671B7B1A04BF58(bot) {
  target = self._id_EC02147FEE952CE2;

  for(;;) {
    targetpos = getclosestpointonnavmesh(target.origin);
    bot _id_59FF79D681BB860C::_id_9E400058EF021B03(targetpos, 64);
    result = bot scripts\engine\utility::waittill_any_in_array_or_timeout(["goal", "bad_path"], 1);

    if(result == "goal") {
      bot _id_22594D942A4F2FA9::_id_6ECF7023EF123BA0(target.entnum);
      break;
    } else if(result == "bad_path") {
      bot _id_22594D942A4F2FA9::_id_6ECF7023EF123BA0(target.entnum);
      return result;
    }
  }
}