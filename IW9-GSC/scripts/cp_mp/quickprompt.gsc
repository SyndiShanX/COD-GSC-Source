/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\quickprompt.gsc
***********************************************/

_id_B6C06DC6663D652E(_id_59C48D2E824E116B, _id_2A29AFAACF2A9D72) {
  _id_59C48D2E824E116B endon("end_wait");
  result = undefined;

  while(!isDefined(result) || result != _id_2A29AFAACF2A9D72)
    self waittill("ok", result);

  _id_59C48D2E824E116B notify("end_wait", 1);
}

_id_3E504361C6E5789E(_id_59C48D2E824E116B, timeout) {
  _id_59C48D2E824E116B endon("end_wait");
  wait(timeout);
  _id_59C48D2E824E116B notify("end_wait", 0);
}

_id_F1C2D46BCB654BDE(_id_2A29AFAACF2A9D72, timeout) {
  _id_59C48D2E824E116B = spawnStruct();
  childthread _id_B6C06DC6663D652E(_id_59C48D2E824E116B, _id_2A29AFAACF2A9D72);
  childthread _id_3E504361C6E5789E(_id_59C48D2E824E116B, timeout);
  _id_59C48D2E824E116B waittill("end_wait", _id_63F39F46151661F8);
  return _id_63F39F46151661F8;
}

_id_0CF06DA592218629(_id_FD2287F1DB15A3E0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "trySayLocalSound"))
    level thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "trySayLocalSound")]](self, _id_FD2287F1DB15A3E0);
}

_id_3FC6BD204B38A2F5() {
  if(!isDefined(level._id_A7073B092595736E))
    level._id_A7073B092595736E = 0;

  _id_2A29AFAACF2A9D72 = level._id_A7073B092595736E;
  level._id_A7073B092595736E = level._id_A7073B092595736E + 1;
  return _id_2A29AFAACF2A9D72;
}

_id_B8DA10AFDEE4ECB6() {
  return getdvarint("dvar_923B34C4661BF18D", 500);
}

_id_1B0DC173255E7DD3(_id_97FB1CD5E88BBF4D) {
  _id_BD28F5A584BF2110 = 1000.0;
  _id_1048E24F7ECFD108 = _id_B8DA10AFDEE4ECB6();
  return (_id_97FB1CD5E88BBF4D + _id_BD28F5A584BF2110 + _id_1048E24F7ECFD108) / 1000;
}

_id_81E08A62A6B5C2FC(timeout) {
  _id_20F555E2261730D5 = 5000.0;

  if(isDefined(timeout))
    return timeout * 1000;

  return getdvarint("dvar_9FEED7A9D0B00557", _id_20F555E2261730D5);
}

_id_48C352E46A0677D1(_id_C8DF752C18209187) {
  if(_id_C8DF752C18209187 == 5 || _id_C8DF752C18209187 == 6)
    return 0;
  else
    return 1;
}

_id_5FE394C76F3BB67E(_id_C8DF752C18209187) {
  if(_id_C8DF752C18209187 == 2)
    return 1;

  return 0;
}

_id_7BA31CB6B21C346F() {
  return istrue(getdvarint("dvar_7023569777F7F76D", 1));
}

_id_9E4834F9AE737884() {
  return isDefined(self._id_CA28D060B3B6AB8E);
}

_id_74C8EB2AAF9F5D14(_id_C8DF752C18209187) {
  if(isDefined(self._id_CA28D060B3B6AB8E))
    return self._id_CA28D060B3B6AB8E.type == _id_C8DF752C18209187;

  return 0;
}

_id_36EDF91561322753(_id_C8DF752C18209187, timeout, callback) {
  if(!_id_7BA31CB6B21C346F()) {
    return;
  }
  if(isDefined(self._id_CA28D060B3B6AB8E) && isDefined(self._id_CA28D060B3B6AB8E._id_AA6C439933F25876) && !self._id_CA28D060B3B6AB8E._id_AA6C439933F25876) {
    return;
  }
  self endon("death_or_disconnect");
  level endon("game_ended");
  _id_2A29AFAACF2A9D72 = _id_3FC6BD204B38A2F5();
  _id_CFC5920255EA9ED2 = _id_81E08A62A6B5C2FC(timeout);
  _id_AA6C439933F25876 = _id_48C352E46A0677D1(_id_C8DF752C18209187);
  _id_5FE394C76F3BB67E = _id_5FE394C76F3BB67E(_id_C8DF752C18209187);
  _func_50D712D830EFFA82(self, _id_C8DF752C18209187, _id_2A29AFAACF2A9D72, int(_id_CFC5920255EA9ED2), _id_5FE394C76F3BB67E);
  self._id_CA28D060B3B6AB8E = spawnStruct();
  self._id_CA28D060B3B6AB8E._id_AA6C439933F25876 = _id_AA6C439933F25876;
  self._id_CA28D060B3B6AB8E.callback = callback;
  self._id_CA28D060B3B6AB8E.type = _id_C8DF752C18209187;
  self._id_CA28D060B3B6AB8E._id_2A29AFAACF2A9D72 = _id_2A29AFAACF2A9D72;
  _id_BC3A23B179629241 = _id_1B0DC173255E7DD3(_id_CFC5920255EA9ED2);
  _id_63F39F46151661F8 = _id_F1C2D46BCB654BDE(_id_2A29AFAACF2A9D72, _id_BC3A23B179629241);

  if(_id_63F39F46151661F8) {
    switch (_id_C8DF752C18209187) {
      case 4:
      case 3:
      case 2:
      case 1:
        _id_0CF06DA592218629("stat_A4C67E28DD65B35F");
        break;
      default:
        break;
    }
  }

  if(isDefined(self._id_CA28D060B3B6AB8E) && isDefined(self._id_CA28D060B3B6AB8E.callback))
    self[[self._id_CA28D060B3B6AB8E.callback]](_id_63F39F46151661F8);

  self._id_CA28D060B3B6AB8E = undefined;
}

_id_24A08F8A03BE8244(_id_8F23C9DC9608A79F) {
  if(isDefined(self._id_CA28D060B3B6AB8E)) {
    if(isDefined(_id_8F23C9DC9608A79F) && _id_8F23C9DC9608A79F && isDefined(self._id_CA28D060B3B6AB8E.callback))
      self[[self._id_CA28D060B3B6AB8E.callback]](0);

    self._id_CA28D060B3B6AB8E = undefined;
    _func_AA1B7C7A8261EFEF(self);
  }
}