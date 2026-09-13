/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_6a3a688cced14074.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14, ::_id_E3D9D27A30E4D693, 2000);
}

_id_E0844A2B7F904B14(bot) {
  if(!bot _id_40E63DD222434655::_id_81B00A2BA10C143A("uav"))
    return 0;

  _id_FDF6F26ABEE82B42 = bot _id_2D121AC0A4E1A5B8::_id_7E7DDFA33EFF2C11();
  _id_FDF6F26ABEE82B42 _id_2D121AC0A4E1A5B8::_id_8500E6AE452B1E19(self._id_E889B543C8E054AE._id_DF15D9EFF00563BE);
  _id_B16F718206F54B7B = 0;

  foreach(player in _id_FDF6F26ABEE82B42.result) {
    if(_id_40E63DD222434655::_id_40034C2FAF09A87B(player))
      _id_B16F718206F54B7B++;
  }

  return self._id_E889B543C8E054AE.basescore + _id_59FF79D681BB860C::_id_9D1AB012058221BB(_id_B16F718206F54B7B, self._id_E889B543C8E054AE._id_E8B4534F27490BC4, self._id_E889B543C8E054AE._id_FFD2B6629C92A80D);
}

_id_E3D9D27A30E4D693(bot) {
  return _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("Killstreak UAV", undefined, "upper body", "", ::_id_35671B7B1A04BF58, self);
}

_id_35671B7B1A04BF58(bot) {
  bot scripts\mp\killstreaks\killstreaks::dokillstreakaction(undefined, 1);
}