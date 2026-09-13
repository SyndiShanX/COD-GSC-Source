/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3745817abb376b9d.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14);
}

_id_E0844A2B7F904B14(bot) {
  _id_72BB89E60D3674DF = 0;
  target = undefined;
  _id_47A3B799C2843055 = bot _id_7845BA34DCF9B77B::_id_7E7DDFA33EFF2C11();

  foreach(fob in _id_47A3B799C2843055) {
    _id_F4F69DA7307E230D = fob.trigger.gameobject;
    _id_53F1776107072C70 = distance(_id_F4F69DA7307E230D.origin, bot.origin);
    basescore = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_53F1776107072C70, self._id_E889B543C8E054AE._id_96AF88C97DB9ED21, self._id_E889B543C8E054AE._id_49E2976CA0C853EF);
    _id_F5576FB178AF593E = _id_F4F69DA7307E230D scripts\mp\gameobjects::getcaptureprogress();

    if(bot.team != _id_F4F69DA7307E230D scripts\mp\gameobjects::getownerteam())
      _id_4864AFBC9D83EA7D = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_F5576FB178AF593E, self._id_E889B543C8E054AE._id_EC6070E1EBB11843, self._id_E889B543C8E054AE._id_7FEF69CEC64A3CF4);
    else
      _id_4864AFBC9D83EA7D = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_F5576FB178AF593E, self._id_E889B543C8E054AE._id_EC6070E1EBB11843, self._id_E889B543C8E054AE._id_02348961FB298F28);

    score = basescore * _id_4864AFBC9D83EA7D;
    score = score + _id_0D74AE0B4AA21186::_id_4E58BF49977D1BFD(fob.name);

    if(score > _id_72BB89E60D3674DF) {
      _id_72BB89E60D3674DF = score;
      target = fob.name;
    }
  }

  if(isDefined(target))
    self._id_DF9D35D9B4BEE654 = _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("control_fob", target, "main", target, ::_id_35671B7B1A04BF58, self, undefined, self._id_E889B543C8E054AE._id_57228F75B014A7B8, self._id_E889B543C8E054AE._id_DAEC6FD98C7CEE50);

  return _id_72BB89E60D3674DF;
}

_id_35671B7B1A04BF58(bot) {
  _id_27A1A1E9BD5F40F0 = self._id_EC02147FEE952CE2;
  destination = scripts\engine\utility::_id_7A2AAA4A09A4D250(scripts\cp_mp\utility\game_utility::getlocalestructarray(_id_27A1A1E9BD5F40F0 + "_bot"));
  _id_332BFCF7ECA6F520 = _id_2695A20D4011076D::getrandompointincircle(destination.origin, destination.radius, undefined, undefined, 1, 1, undefined, undefined);
  bot _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_332BFCF7ECA6F520, 32);
  result = undefined;
  timeout = gettime() + 20000;

  while(gettime() < timeout) {
    bot botpressbutton("sprint", 1);
    result = bot scripts\engine\utility::waittill_any_in_array_or_timeout(["goal", "bad_path"], 1);

    if(result == "goal") {
      wait(randomfloatrange(1, 2.5));
      break;
    } else if(result != "timeout")
      return result;
  }
}