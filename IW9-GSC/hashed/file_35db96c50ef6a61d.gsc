/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_35db96c50ef6a61d.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14, undefined, 2000);
}

_id_E0844A2B7F904B14(bot) {
  _id_8B2A3B0E3F1CD3CF = _id_2A5852C404D2236E(bot);

  if(!isDefined(_id_8B2A3B0E3F1CD3CF))
    return 0;

  _id_200C8F755E8F626B = _id_8B2A3B0E3F1CD3CF.target;
  self._id_DF9D35D9B4BEE654 = _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("go_to_camp_position", _id_200C8F755E8F626B, "main", _id_200C8F755E8F626B.target, ::_id_35671B7B1A04BF58, self, ::_id_F4CAAE7E8AF9D32C);
  return _id_8B2A3B0E3F1CD3CF.score;
}

_id_2A5852C404D2236E(bot) {
  _id_49FFFC1CE970E26D = isDefined(bot.primaryweaponobj) && bot _id_40E63DD222434655::_id_813A1A6F2C5ABDDB(bot.primaryweaponobj, self._id_E889B543C8E054AE._id_D0708C53F9AEDBBE);

  if(!_id_49FFFC1CE970E26D)
    return undefined;

  _id_0B01971EF554BAC8 = bot _id_1076881DD9127338::_id_7E7DDFA33EFF2C11();
  _id_8B2A3B0E3F1CD3CF = bot _id_40E63DD222434655::_id_8A0FA223B19E44F4(_id_0B01971EF554BAC8, self._id_E889B543C8E054AE._id_96AF88C97DB9ED21, self._id_E889B543C8E054AE._id_49E2976CA0C853EF, 1);

  if(!isDefined(_id_8B2A3B0E3F1CD3CF))
    return undefined;

  _id_9073E5955EAEBE2C = _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_40E63DD222434655::_id_1C51F7C46A848DDD(), self._id_E889B543C8E054AE._id_E23500DBD314BAE2, self._id_E889B543C8E054AE._id_E58A5E1EFEB78937);
  _id_8B2A3B0E3F1CD3CF.score = _id_8B2A3B0E3F1CD3CF.score + _id_9073E5955EAEBE2C;
  return _id_8B2A3B0E3F1CD3CF;
}

_id_35671B7B1A04BF58(bot) {
  _id_200C8F755E8F626B = self._id_EC02147FEE952CE2;
  bot _id_1076881DD9127338::_id_7DBE596500A2E27C(_id_200C8F755E8F626B);
  _id_5BE401736B4D21B8 = _id_200C8F755E8F626B scripts\engine\utility::get_target_array();

  for(;;) {
    _id_CFF075B05A95577B = scripts\engine\utility::random(_id_5BE401736B4D21B8);
    _id_E24929C0E254D7B4 = getclosestpointonnavmesh(_id_CFF075B05A95577B.origin);

    if(!isDefined(_id_E24929C0E254D7B4))
      return "No point on navmesh around " + _id_CFF075B05A95577B.origin;

    bot _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_E24929C0E254D7B4, 4);
    result = bot scripts\engine\utility::waittill_any_in_array_return(["goal", "bad_path"]);

    if(result == "goal") {
      _id_5F50D68561839648 = randomfloatrange(3, 8);
      forwardvec = anglesToForward(_id_CFF075B05A95577B.angles) * 100;
      bot botlookatpoint(bot getEye() + forwardvec, _id_5F50D68561839648, "script_forced");
      stance = _id_CFF075B05A95577B.script_parameters;

      if(!isDefined(stance))
        stance = "crouch";

      bot botsetstance(stance);
      wait(_id_5F50D68561839648);
      continue;
    }

    return result;
  }
}

_id_F4CAAE7E8AF9D32C(action) {
  if(_id_0D74AE0B4AA21186::_id_D57DD414963503D1()) {
    self botlookatpoint(undefined);
    self botsetstance("none");
    _id_1076881DD9127338::_id_5F6E68B080316FCF(action._id_EC02147FEE952CE2);
  }
}