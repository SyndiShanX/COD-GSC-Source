/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_32abd1c08a25abb5.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14, ::_id_E3D9D27A30E4D693);
}

_id_E0844A2B7F904B14(bot) {
  if(!bot _id_FC5D9D6DC490CE2E())
    return 0;

  if(bot.armorhealth >= self._id_E889B543C8E054AE._id_AE436A56F4DC7ADD)
    return 0;

  _id_FDF6F26ABEE82B42 = bot _id_2D121AC0A4E1A5B8::_id_7E7DDFA33EFF2C11();
  _id_FDF6F26ABEE82B42 _id_2D121AC0A4E1A5B8::_id_2F1735D1CB737A0C(bot);
  _id_C530728F20222D70 = self._id_E889B543C8E054AE._id_71BDBA3F5C7A939D[self._id_E889B543C8E054AE._id_71BDBA3F5C7A939D.size - 1];

  if(_id_FDF6F26ABEE82B42.result.size > 0) {
    player = _id_FDF6F26ABEE82B42.result[0];
    _id_C530728F20222D70 = _id_59FF79D681BB860C::_id_9D1AB012058221BB(distance(player.origin, bot.origin), self._id_E889B543C8E054AE._id_A8D37F0EA66F877F, self._id_E889B543C8E054AE._id_71BDBA3F5C7A939D);
  }

  return self._id_E889B543C8E054AE.basescore + _id_C530728F20222D70;
}

_id_E3D9D27A30E4D693(bot) {
  return _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("Equip Armor", undefined, "upper body", "", ::_id_35671B7B1A04BF58, self, ::_id_F4CAAE7E8AF9D32C);
}

_id_35671B7B1A04BF58(bot) {
  if(!bot _id_FC5D9D6DC490CE2E())
    return "Can't equip";

  bot botsetflag("ignore_script_weapon", 0);
  bot _id_07C40FA80892A721::_id_9F1608BD570DD94C(1);
  bot scripts\engine\utility::waittill_any_in_array_or_timeout(["insertArmorComplete"], 5);
}

_id_FC5D9D6DC490CE2E() {
  return istrue(level._id_D73697030C5D4E05) && !istrue(self.insertingarmorplate) && _id_07C40FA80892A721::_id_0600F6CF462E983F() > 0 && _id_07C40FA80892A721::_id_CF37789D18FBCC1B() && !self isswitchingweapon();
}

_id_F4CAAE7E8AF9D32C(action) {
  if(_id_0D74AE0B4AA21186::_id_D57DD414963503D1())
    self botsetflag("ignore_script_weapon", 1);
}