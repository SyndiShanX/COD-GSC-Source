/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4265.gsc
**************************************/

_id_A314(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  _id_DEB9();

  if(isDefined(var_1) && isDefined(isDefined(var_2)))
    level thread _id_A310(var_0, var_1, var_2);

  if(isDefined(var_3) && isDefined(isDefined(var_4)))
    level thread _id_A311(var_0, var_3, var_4);

  if(isDefined(var_5) && isDefined(isDefined(var_6)))
    level thread _id_A312(var_0, var_5, var_6);

  if(isDefined(var_7))
    level thread _id_FDB9(var_0, var_7, "shipcrib_jackal_serv_top_01");

  if(isDefined(var_8))
    level thread _id_FDB9(var_0, var_8, "shipcrib_jackal_serv_top_02");

  if(isDefined(var_9))
    level thread _id_FDB9(var_0, var_9, "shipcrib_jackal_serv_top_03");
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
  level._id_EC87["jackal_serv_grnd_inaccess_secA_A"] = #animtree;
  level._id_EC85["jackal_serv_grnd_inaccess_secA_A"]["idle_base"] = % shipcrib_jackal_serv_seca_idle_guya;
  level._id_EC85["jackal_serv_grnd_inaccess_secA_A"]["idle_anims"] = [%shipcrib_jackal_serv_seca_loop1_guya, %shipcrib_jackal_serv_seca_loop2_guya, %shipcrib_jackal_serv_seca_loop3_guya];
  level._id_EC87["jackal_serv_grnd_inaccess_secA_B"] = #animtree;
  level._id_EC85["jackal_serv_grnd_inaccess_secA_B"]["idle_base"] = % shipcrib_jackal_serv_seca_idle_guyb;
  level._id_EC85["jackal_serv_grnd_inaccess_secA_B"]["idle_anims"] = [%shipcrib_jackal_serv_seca_loop1_guyb, %shipcrib_jackal_serv_seca_loop2_guyb, %shipcrib_jackal_serv_seca_loop3_guyb];
  level._id_EC87["jackal_serv_grnd_inaccess_secB_A"] = #animtree;
  level._id_EC85["jackal_serv_grnd_inaccess_secB_A"]["idle_base"] = % shipcrib_jackal_serv_secb_idle_guya;
  level._id_EC85["jackal_serv_grnd_inaccess_secB_A"]["idle_anims"] = [%shipcrib_jackal_serv_secb_loop1_guya, %shipcrib_jackal_serv_secb_loop2_guya];
  level._id_EC87["jackal_serv_grnd_inaccess_secB_B"] = #animtree;
  level._id_EC85["jackal_serv_grnd_inaccess_secB_B"]["idle_base"] = % shipcrib_jackal_serv_secb_idle_guyb;
  level._id_EC85["jackal_serv_grnd_inaccess_secB_B"]["idle_anims"] = [%shipcrib_jackal_serv_secb_loop1_guyb, %shipcrib_jackal_serv_secb_loop2_guyb];
  level._id_EC85["generic"]["jackal_serv_grnd_inaccess_secC_A_1"][0] = % shipcrib_jackal_serv_secc_loop1_guya;
  level._id_EC85["generic"]["jackal_serv_grnd_inaccess_secC_A_2"][0] = % shipcrib_jackal_serv_secc_loop2_guya;
  level._id_EC85["generic"]["jackal_serv_grnd_inaccess_secC_B_1"][0] = % shipcrib_jackal_serv_secc_loop1_guyb;
  level._id_EC85["generic"]["jackal_serv_grnd_inaccess_secC_B_2"][0] = % shipcrib_jackal_serv_secc_loop2_guyb;
  level._id_EC85["generic"]["shipcrib_jackal_serv_top_01"][0] = % shipcrib_jackal_serv_top_01;
  level._id_EC85["generic"]["shipcrib_jackal_serv_top_02"][0] = % shipcrib_jackal_serv_top_02;
  level._id_EC85["generic"]["shipcrib_jackal_serv_top_03"][0] = % shipcrib_jackal_serv_top_03;
}

_id_A310(var_0, var_1, var_2) {
  var_1._id_1FBB = "jackal_serv_grnd_inaccess_secA_A";
  var_1._id_1F1C = var_0;
  var_2._id_1FBB = "jackal_serv_grnd_inaccess_secA_B";
  var_2._id_1F1C = var_0;
  var_0 thread scripts\sp\idles::_id_CC80([var_1, var_2]);
}

_id_A311(var_0, var_1, var_2) {
  var_1._id_1FBB = "jackal_serv_grnd_inaccess_secB_A";
  var_1._id_1F1C = var_0;
  var_2._id_1FBB = "jackal_serv_grnd_inaccess_secB_B";
  var_2._id_1F1C = var_0;
  var_0 thread scripts\sp\idles::_id_CC80([var_1, var_2]);
}

_id_A312(var_0, var_1, var_2) {
  var_3 = randomintrange(1, 3);
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "jackal_serv_grnd_inaccess_secC_A_" + var_3);
  var_0 thread scripts\sp\anim::_id_1ECC(var_2, "jackal_serv_grnd_inaccess_secC_B_" + var_3);
}

_id_FDB9(var_0, var_1, var_2) {
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, var_2);
}