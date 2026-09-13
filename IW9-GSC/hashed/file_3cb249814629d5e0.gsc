/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3cb249814629d5e0.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14, undefined, 250);
}

_id_E0844A2B7F904B14(bot) {
  _id_1BA734C0960ED497 = undefined;
  _id_55110DCE256E40CD = undefined;
  _id_FDF6F26ABEE82B42 = bot _id_5120873D6D2BB7E2::_id_7E7DDFA33EFF2C11();

  foreach(vehicle in _id_FDF6F26ABEE82B42) {
    _id_2812F26E7D64047F = _id_88CC28B68D5FBEF8(bot, vehicle);

    if(isDefined(_id_2812F26E7D64047F) && (!isDefined(_id_55110DCE256E40CD) || _id_2812F26E7D64047F < _id_55110DCE256E40CD)) {
      _id_1BA734C0960ED497 = vehicle;
      _id_55110DCE256E40CD = _id_2812F26E7D64047F;
    }
  }

  if(!isDefined(_id_1BA734C0960ED497))
    return 0;

  self._id_DF9D35D9B4BEE654 = _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("Evade Cars", _id_1BA734C0960ED497, "main", _id_1BA734C0960ED497.unique_id, ::_id_35671B7B1A04BF58, self);
  return self._id_E889B543C8E054AE.basescore;
}

_id_88CC28B68D5FBEF8(bot, vehicle) {
  _id_B671DDA1C1164EC4 = vehicle vehicle_getvelocity();
  speed = length(_id_B671DDA1C1164EC4) * self._id_E889B543C8E054AE._id_3B344B36C6469A5D;
  _id_A61C75B156FC1EE0 = vehicle _meth_80715C3A9A2DDF68();
  width = min(_id_A61C75B156FC1EE0[0], _id_A61C75B156FC1EE0[1]) + self._id_E889B543C8E054AE._id_DA291FC01DAA215E;
  height = max(_id_A61C75B156FC1EE0[2], width * 2);
  ignore = scripts\engine\utility::array_combine([vehicle], vehicle.owners);
  _id_C1998072EE17BF47 = _id_B671DDA1C1164EC4 * self._id_E889B543C8E054AE._id_3B344B36C6469A5D;

  if(length(_id_C1998072EE17BF47) < self._id_E889B543C8E054AE._id_BD58D59C468151DD)
    _id_C1998072EE17BF47 = vectorNormalize(_id_B671DDA1C1164EC4) * self._id_E889B543C8E054AE._id_BD58D59C468151DD;

  trace = scripts\engine\trace::capsule_trace(vehicle.origin, vehicle.origin + _id_C1998072EE17BF47, width, height, (0, 90, 0), ignore);

  if(isDefined(trace["entity"]) && trace["entity"] == bot)
    return distance(bot.origin, vehicle.origin) / speed;

  return undefined;
}

_id_35671B7B1A04BF58(bot) {
  vehicle = self._id_EC02147FEE952CE2;
  _id_AA4C489CA6DBF82F = anglesToForward(bot.angles);
  _id_B671DDA1C1164EC4 = vehicle vehicle_getvelocity();
  _id_EFAA9AB3C88C72D8 = vectorNormalize(_id_B671DDA1C1164EC4);
  dot = vectordot(_id_AA4C489CA6DBF82F, _id_EFAA9AB3C88C72D8);
  _id_313DFD46E0BDD035 = abs(dot) < 0.7;
  _id_E4CE48294CFEE033 = vectorcross(_id_EFAA9AB3C88C72D8, vectorNormalize(bot.origin - vehicle.origin))[2] < 0;
  angledelta = 0;

  if(_id_313DFD46E0BDD035) {
    moveforward = _id_E4CE48294CFEE033;
    _id_01ED1D46DA636E25 = vectorcross(_id_AA4C489CA6DBF82F, vectorNormalize(vehicle.origin - bot.origin))[2] < 0;

    if(!_id_01ED1D46DA636E25)
      moveforward = !moveforward;

    angledelta = scripts\engine\utility::ter_op(moveforward, 0, -180);
  } else {
    _id_5FC37E3C01B0E412 = _id_E4CE48294CFEE033;

    if(dot > 0)
      _id_5FC37E3C01B0E412 = !_id_5FC37E3C01B0E412;

    angledelta = scripts\engine\utility::ter_op(_id_5FC37E3C01B0E412, 90, -90);
  }

  yaw = angleclamp(bot.angles[1] + angledelta);
  _id_9C3A2316A9FB0DCC = 1;
  bot botsetscriptmove(yaw, _id_9C3A2316A9FB0DCC, 1);
  bot botpressbutton("sprint", _id_9C3A2316A9FB0DCC);
}