/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\online_event.gsc
***********************************************/

init() {
  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587() && scripts\mp\utility\game::matchmakinggame())
    level._id_3392F98172A332D7 = 1;
}

_id_3392F98172A332D7() {
  return istrue(level._id_3392F98172A332D7);
}

_id_ABD8520A1B77AB7B(_id_5EA5F0ACD4FD6E5F) {
  _id_E6D96E0E82E3743A = undefined;

  switch (_id_5EA5F0ACD4FD6E5F) {
    case "br_reusable_loot_cache":
    case "br_loot_cache":
      _id_E6D96E0E82E3743A = 0;
      break;
    case "br_loot_cache_lege":
      _id_E6D96E0E82E3743A = 1;
      break;
  }

  return _id_E6D96E0E82E3743A;
}

_id_4C8D860C9E17FA76(_id_6C8B8AC0C7274797) {
  self _meth_DB073176839D77FB("93", [84, _id_6C8B8AC0C7274797, 86, 1]);

  if(!isDefined(self._id_52E352F8923ED6F9))
    self._id_52E352F8923ED6F9 = [];

  self._id_52E352F8923ED6F9[self._id_52E352F8923ED6F9.size] = _id_6C8B8AC0C7274797;
  thread scripts\mp\hud_message::showsplash("mgl_online_event_tactical_boost_obtain", _id_6C8B8AC0C7274797);
}

_id_A23861C0F0635CF4(instance) {
  if(isbot(self)) {
    return;
  }
  if(!isDefined(self._id_09806F56704A9B97))
    self._id_09806F56704A9B97 = 0;

  _id_5EA5F0ACD4FD6E5F = instance.type;
  _id_E6D96E0E82E3743A = _id_ABD8520A1B77AB7B(_id_5EA5F0ACD4FD6E5F);

  if(!isDefined(_id_E6D96E0E82E3743A)) {
    return;
  }
  _id_F654C0A4060B57FF = self _meth_6477EA4E9CC93C9B();
  _id_F654C0A4060B57FF = _id_9D27EF5AADBFAF3B(_id_F654C0A4060B57FF);

  if(_id_F654C0A4060B57FF.size == 0) {
    return;
  }
  _id_745A0BA506902BFA = self _meth_AB8D2834B183F17B(_id_E6D96E0E82E3743A);

  if(self._id_09806F56704A9B97 > 0) {
    _id_131DE4E9ACB63176 = self _meth_702EC3DF792AE6AF(0);
    _id_745A0BA506902BFA = _id_745A0BA506902BFA + self._id_09806F56704A9B97 * _id_131DE4E9ACB63176;
  }

  if(!istrue(self._id_D985F56434E12955)) {
    _id_560D37638266F99E = self _meth_702EC3DF792AE6AF(1);
    _id_EF778C8E38832D32 = self _meth_84D8D6E3E9576AF8();
    _id_745A0BA506902BFA = _id_745A0BA506902BFA + _id_EF778C8E38832D32 * _id_560D37638266F99E;
  }

  if(_id_745A0BA506902BFA == 0.0) {
    return;
  }
  _id_500ACD7A775DB207 = randomfloat(1.0);
  _id_B7AB28868F552DF5 = getdvarint("dvar_433DCBCDB2E19063", 1);

  if(_id_745A0BA506902BFA * _id_B7AB28868F552DF5 < _id_500ACD7A775DB207) {
    self._id_09806F56704A9B97 = self._id_09806F56704A9B97 + 1;
    return;
  }

  _id_0746F5F0494D6253 = 0;

  for(index = 0; index < _id_F654C0A4060B57FF.size; index++)
    _id_0746F5F0494D6253 = _id_0746F5F0494D6253 + _id_F654C0A4060B57FF[index].weight;

  _id_7EC3EFADC5D1BEAC = randomint(_id_0746F5F0494D6253);
  _id_6C8B8AC0C7274797 = 0;

  for(index = 0; index < _id_F654C0A4060B57FF.size; index++) {
    _id_7EC3EFADC5D1BEAC = _id_7EC3EFADC5D1BEAC - _id_F654C0A4060B57FF[index].weight;

    if(_id_7EC3EFADC5D1BEAC <= 0) {
      _id_6C8B8AC0C7274797 = _id_F654C0A4060B57FF[index].id;
      break;
    }
  }

  if(_id_6C8B8AC0C7274797 == 0) {
    return;
  }
  if(getdvarint("dvar_834CF04540F17E6E", 1) == 1)
    _id_5D76F37152BCF8A7::_id_1610B6BB7C7587F8(instance.origin, instance.angles, _id_6C8B8AC0C7274797);
  else
    _id_4C8D860C9E17FA76(_id_6C8B8AC0C7274797);

  self._id_D985F56434E12955 = 1;
  self._id_09806F56704A9B97 = 0;
}

_id_9D27EF5AADBFAF3B(_id_F654C0A4060B57FF) {
  _id_49010211722113D6 = self _meth_DA5D6F8B4926CB90();
  _id_6C2AC9EAF9D1B5D3 = [];

  for(index = 0; index < _id_F654C0A4060B57FF.size; index++) {
    if(isDefined(_id_49010211722113D6) && scripts\engine\utility::array_contains(_id_49010211722113D6, _id_F654C0A4060B57FF[index].id)) {
      continue;
    }
    if(isDefined(self._id_52E352F8923ED6F9) && scripts\engine\utility::array_contains(self._id_52E352F8923ED6F9, _id_F654C0A4060B57FF[index].id)) {
      continue;
    }
    _id_6C2AC9EAF9D1B5D3[_id_6C2AC9EAF9D1B5D3.size] = _id_F654C0A4060B57FF[index];
  }

  return _id_6C2AC9EAF9D1B5D3;
}

_id_CE0A9E4004E1B441(eventtype) {
  return self _meth_ 2 F1F1B362DD1607(eventtype);
}

_id_822DA8E20DC13E9F(eventtype) {
  return self _meth_A44AC130E11B25C4(eventtype);
}

_id_8730EF1BFE106CBE(eventtype) {
  return self _meth_74C7C5B9C25D85D9(eventtype);
}