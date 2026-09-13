/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_4ae1a952802852f7.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14, ::_id_E3D9D27A30E4D693);
}

_id_E0844A2B7F904B14(bot) {
  return self._id_E889B543C8E054AE.basescore;
}

_id_E3D9D27A30E4D693(bot) {
  return _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("wander", undefined, "main", "", ::_id_35671B7B1A04BF58, self);
}

_id_35671B7B1A04BF58(bot) {
  if(isDefined(level.bot_funcs["mp_wander_select_destination"]))
    _id_E24929C0E254D7B4 = bot[[level.bot_funcs["mp_wander_select_destination"]]]();
  else
    _id_E24929C0E254D7B4 = bot _id_59FF79D681BB860C::_id_5E0E534F768708A3();

  if(!isDefined(_id_E24929C0E254D7B4))
    return "No destination";

  bot _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_E24929C0E254D7B4, 400);
  result = bot scripts\engine\utility::waittill_any_in_array_or_timeout(["goal", "bad_path", "long_path"], 15);

  if(result != "goal" && result != "timeout")
    return result;
}