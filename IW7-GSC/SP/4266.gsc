/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4266.gsc
**************************************/

_id_A314(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  _id_DEB9();

  if(isDefined(var_1))
    level thread _id_FDB5(var_0, var_1, "shipcrib_jackal_serv_grnd_A");

  if(isDefined(var_2))
    level thread _id_FDB5(var_0, var_2, "shipcrib_jackal_serv_grnd_B");

  if(isDefined(var_3))
    level thread _id_FDB5(var_0, var_3, "shipcrib_jackal_serv_grnd_C");

  if(isDefined(var_4))
    level thread _id_FDB9(var_0, var_4, "shipcrib_jackal_serv_top_01");

  if(isDefined(var_5))
    level thread _id_FDB9(var_0, var_5, "shipcrib_jackal_serv_top_02");

  if(isDefined(var_6))
    level thread _id_FDB9(var_0, var_6, "shipcrib_jackal_serv_top_03");
}

_id_A315(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_1F1C))
      var_2._id_1F1C notify("ambient_idle_scene_end");

    var_2 notify("cleaned");

    if(isDefined(var_2._id_B14F))
      var_2 scripts\sp\utility::_id_1101B();

    if(isai(var_2))
      var_2 _meth_81D0();

    var_2 delete();
  }
}

#using_animtree("generic_human");

_id_DEB9() {
  var_0 = [%shipcrib_jackal_serv_seca_enter1, %shipcrib_jackal_serv_seca_idle1, %shipcrib_jackal_serv_seca_exit1];
  var_1 = [%shipcrib_jackal_serv_seca_enter2, %shipcrib_jackal_serv_seca_idle2, %shipcrib_jackal_serv_seca_exit2];
  var_2 = [%shipcrib_jackal_serv_seca_enter3, %shipcrib_jackal_serv_seca_idle3, %shipcrib_jackal_serv_seca_exit3];
  var_3 = [%shipcrib_jackal_serv_seca_enter4, %shipcrib_jackal_serv_seca_idle4, %shipcrib_jackal_serv_seca_exit4];
  level._id_EC87["shipcrib_jackal_serv_grnd_A"] = #animtree;
  level._id_EC85["shipcrib_jackal_serv_grnd_A"]["idle_base"] = % shipcrib_jackal_serv_seca_idle_guya;
  level._id_EC85["shipcrib_jackal_serv_grnd_A"]["idle_anims"] = [var_0, var_1, var_2, var_3];
  var_4 = [%shipcrib_jackal_serv_secb_enter1, %shipcrib_jackal_serv_secb_idle1, %shipcrib_jackal_serv_secb_exit1];
  var_5 = [%shipcrib_jackal_serv_secb_enter2, %shipcrib_jackal_serv_secb_idle2, %shipcrib_jackal_serv_secb_exit2];
  var_6 = [%shipcrib_jackal_serv_secb_enter3, %shipcrib_jackal_serv_secb_idle3, %shipcrib_jackal_serv_secb_exit3];
  level._id_EC87["shipcrib_jackal_serv_grnd_B"] = #animtree;
  level._id_EC85["shipcrib_jackal_serv_grnd_B"]["idle_base"] = % shipcrib_jackal_serv_secb_idle_guya;
  level._id_EC85["shipcrib_jackal_serv_grnd_B"]["idle_anims"] = [var_4, var_5, var_6];
  var_7 = [%shipcrib_jackal_serv_secc_enter1, %shipcrib_jackal_serv_secc_idle1, %shipcrib_jackal_serv_secc_exit1];
  var_8 = [%shipcrib_jackal_serv_secc_enter2, %shipcrib_jackal_serv_secc_idle2, %shipcrib_jackal_serv_secc_exit2];
  level._id_EC87["shipcrib_jackal_serv_grnd_C"] = #animtree;
  level._id_EC85["shipcrib_jackal_serv_grnd_C"]["idle_base"] = % shipcrib_jackal_serv_secc_idle_guya;
  level._id_EC85["shipcrib_jackal_serv_grnd_C"]["idle_anims"] = [var_7, var_8];
  level._id_EC85["generic"]["shipcrib_jackal_serv_top_01"][0] = % shipcrib_jackal_serv_top_01;
  level._id_EC85["generic"]["shipcrib_jackal_serv_top_02"][0] = % shipcrib_jackal_serv_top_02;
  level._id_EC85["generic"]["shipcrib_jackal_serv_top_03"][0] = % shipcrib_jackal_serv_top_03;
}

_id_FDB5(var_0, var_1, var_2) {
  var_1._id_1FBB = var_2;
  var_1._id_1F1C = var_0;
  var_0 thread scripts\sp\idles::_id_CC7F(var_1, 0);
}

_id_FDB9(var_0, var_1, var_2) {
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, var_2);
}