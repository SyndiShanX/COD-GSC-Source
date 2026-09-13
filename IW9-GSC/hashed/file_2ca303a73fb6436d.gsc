/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2ca303a73fb6436d.gsc
***********************************************/

_id_EDA57308516BFC5F() {
  return _id_0D74AE0B4AA21186::_id_BFFB5B682A4EF6A2(::_id_E0844A2B7F904B14, ::_id_E3D9D27A30E4D693);
}

_id_E0844A2B7F904B14(bot) {
  return 1;
}

_id_E3D9D27A30E4D693(bot) {
  return _id_0D74AE0B4AA21186::_id_FF35A4D756374EDE("Auto Run Map", undefined, "main", "", ::_id_35671B7B1A04BF58, self);
}

_id_35671B7B1A04BF58(bot) {
  for(;;) {
    if(getdvarint("dvar_5749A8474F4DAB7D") == 1) {
      setDvar("dvar_57E665AEF01B95A9", 0);
      _id_98A23B0122776E76 = getdvarvector("dvar_747A3D0EE28AC5A8", (0, 0, 0));
      bot _id_59FF79D681BB860C::_id_9E400058EF021B03(_id_98A23B0122776E76, 20);
      result = bot scripts\engine\utility::waittill_any_in_array_return(["goal", "bad_path"]);

      if(isDefined(result) && result == "goal")
        setDvar("dvar_57E665AEF01B95A9", 1);
      else
        setDvar("dvar_57E665AEF01B95A9", 2);

      setDvar("dvar_5749A8474F4DAB7D", 0);
      continue;
    }

    wait 0.5;
  }
}