/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_67bad8bd9685e057.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14);
}

_id_E0844A2B7F904B14(bot) {
  domflag = undefined;

  if(isDefined(self._id_13B45DAA3E1C211A) && bot.team != self._id_13B45DAA3E1C211A scripts\mp\gameobjects::getownerteam())
    domflag = self._id_13B45DAA3E1C211A;
  else {
    self._id_13B45DAA3E1C211A = undefined;
    domflags = bot _id_47366BEB5BA9FA22::_id_7E7DDFA33EFF2C11();

    if(domflags.size <= 0)
      return 0;

    domflag = _id_2613AEC5FA0A8620(domflags);
  }

  self._id_DF9D35D9B4BEE654 = _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("Capture Flag", domflag, "main", "", ::_id_35671B7B1A04BF58, self);
  return self._id_E889B543C8E054AE.basescore;
}

_id_2613AEC5FA0A8620(domflags) {
  weights = self._id_E889B543C8E054AE._id_563192EDA3CF18C5;
  _id_803EAA59E4A3CA2B = min(weights.size, domflags.size);
  _id_15BC73511322996C = 0;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_803EAA59E4A3CA2B; _id_AC0E594AC96AA3A8++)
    _id_15BC73511322996C = _id_15BC73511322996C + weights[_id_AC0E594AC96AA3A8];

  index = 0;
  _id_77B777BD75DB2FF0 = 0;

  for(weight = randomintrange(0, _id_15BC73511322996C); index < _id_803EAA59E4A3CA2B; index++) {
    _id_77B777BD75DB2FF0 = _id_77B777BD75DB2FF0 + weights[index];

    if(weight < _id_77B777BD75DB2FF0) {
      break;
    }
  }

  return domflags[index];
}

_id_35671B7B1A04BF58(bot) {
  domflag = self._id_EC02147FEE952CE2;
  self._id_A0185A724941F02F._id_13B45DAA3E1C211A = domflag;
  _id_9920C1B439193F77 = 16;

  while(bot.team != domflag scripts\mp\gameobjects::getownerteam()) {
    _id_332BFCF7ECA6F520 = _id_6F7D8428F06122A7(domflag, _id_9920C1B439193F77);
    bot _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_332BFCF7ECA6F520, _id_9920C1B439193F77);
    result = scripts\engine\utility::waittill_any_ents_or_timeout_return(15, bot, "bad_path", bot, "long_path", bot, "goal");

    if(result == "goal")
      wait 1;
  }
}

_id_6F7D8428F06122A7(domflag, _id_EB4E83BDEB266116) {
  radius = domflag.trigger.radius;
  _id_4B623D88FD385C86 = (radius - _id_EB4E83BDEB266116) / radius;
  r = randomfloatrange(0, radius * _id_4B623D88FD385C86);
  _id_F157E2C858DD6237 = randomfloat(360);
  offset = (r * cos(_id_F157E2C858DD6237), r * sin(_id_F157E2C858DD6237), 0);
  _id_C1D1FC4D9D46438D = (domflag.trigger.height + 30) * -1;
  contents = scripts\engine\trace::create_contents(0, 1, 1, 1, 0, 0, 1);
  _id_332BFCF7ECA6F520 = scripts\engine\utility::drop_to_ground(domflag.curorigin + offset, domflag.trigger.height, _id_C1D1FC4D9D46438D, undefined, contents);
  return getclosestpointonnavmesh(_id_332BFCF7ECA6F520);
}