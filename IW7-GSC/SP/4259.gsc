/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 4259.gsc
**************************************/

_id_3B9D(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  anims();
  _id_DEB9();

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(!isDefined(var_4)) {
    var_4 = 1;
  }

  if(!isDefined(var_5)) {
    var_5 = 1;
  }

  if(!isDefined(var_6)) {
    var_6 = 1;
  }

  if(!isDefined(var_7)) {
    var_7 = 1;
  }

  if(!isDefined(var_8)) {
    var_8 = 1;
  }

  if(!isDefined(var_9)) {
    var_9 = 0;
  }

  if(var_0) {
    level thread _id_EB97();
  }

  if(var_1) {
    level thread _id_EB96();
  }

  if(var_2) {
    level thread _id_EB98();
  }

  if(var_3) {
    level thread _id_EB99();
  }

  if(var_4) {
    level thread _id_FDA6();
    level thread _id_FDA7();
  }

  if(var_5) {
    level thread _id_FDA8();
    level thread _id_FDA9();
    level thread _id_FDAD();
  }

  if(var_6) {
    level thread _id_FDA4();
    level thread _id_FDA5();
  }

  if(var_7) {
    level thread _id_FDAA();
    level thread _id_FDAB();
  }

  if(var_8) {
    level thread _id_FDA3();
  }

  if(var_9) {
    level thread _id_FDAC();
  }
}

_id_3B9E() {
  var_0 = _id_0EFB::_id_FD9C("catwalks");
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_armory"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_secA"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_secB"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_secC"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_sec1A"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_sec1B"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_sec2A"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_sec2B"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_sec3A"));
  var_0 = scripts\engine\utility::array_combine(var_0, _id_0EFB::_id_FD9C("catwalks_sec3B"));

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_1DF6)) {
      var_2._id_1DF6 notify("ambient_idle_scene_end");
    }
  }

  _id_0EFB::_id_FDBB("catwalks");
  _id_0EFB::_id_FDBB("catwalks_armory");
  _id_0EFB::_id_FDBB("catwalks_secA");
  _id_0EFB::_id_FDBB("catwalks_secB");
  _id_0EFB::_id_FDBB("catwalks_secC");
  _id_0EFB::_id_FDBB("catwalks_sec1A");
  _id_0EFB::_id_FDBB("catwalks_sec1B");
  _id_0EFB::_id_FDBB("catwalks_sec2A");
  _id_0EFB::_id_FDBB("catwalks_sec2B");
  _id_0EFB::_id_FDBB("catwalks_sec3A");
  _id_0EFB::_id_FDBB("catwalks_sec3B");
}

#using_animtree("generic_human");

anims() {
  level._id_EC85["generic"]["shipcrib_hangar_catwalk_01"][0] = % shipcrib_hangar_catwalk_01;
  level._id_EC85["generic"]["shipcrib_hangar_catwalk_02"][0] = % shipcrib_hangar_catwalk_02;
  level._id_EC85["generic"]["shipcrib_hangar_catwalk_idle_d_01"][0] = % shipcrib_hangar_catwalk_idle_d_01;
  level._id_EC85["generic"]["shipcrib_hangar_catwalk_idle_a_01"][0] = % shipcrib_hangar_catwalk_idle_a_01;
  level._id_EC85["generic"]["shipcrib_hangar_catwalk_idle_a_02"][0] = % shipcrib_hangar_catwalk_idle_a_02;
  level._id_EC85["generic"]["shipcrib_hangar_catwalk_idle_b_01"][0] = % shipcrib_hangar_catwalk_idle_b_01;
  level._id_EC85["generic"]["shipcrib_hangar_catwalk_idle_b_02"][0] = % shipcrib_hangar_catwalk_idle_b_02;
  level._id_EC85["generic"]["shipcrib_hangar_catwalk_idle_c_01"][0] = % shipcrib_hangar_catwalk_idle_c_01;
  level._id_EC85["generic"]["shipcrib_hangar_catwalk_idle_c_02"][0] = % shipcrib_hangar_catwalk_idle_c_02;
  level._id_EC85["generic"]["shipcrib_hangar_lower_jackal_catwalk_02"][0] = % shipcrib_hangar_lower_jackal_catwalk_02;
  level._id_EC85["generic"]["shipcrib_hangar_lower_jackal_catwalk_03"][0] = % shipcrib_hangar_lower_jackal_catwalk_03;
  level._id_EC85["generic"]["shipcrib_hangar_lower_jackal_catwalk_05"][0] = % shipcrib_hangar_lower_jackal_catwalk_05;
  level._id_EC85["generic"]["shipcrib_hangar_lower_jackal_catwalk_06"][0] = % shipcrib_hangar_lower_jackal_catwalk_06;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secA_1_guyA"][0] = % shipcrib_upper_catwalk_seca_1_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secA_1_guyB"][0] = % shipcrib_upper_catwalk_seca_1_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secA_2_guyA"][0] = % shipcrib_upper_catwalk_seca_2_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secA_2_guyB"][0] = % shipcrib_upper_catwalk_seca_2_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secA_3_guyA"][0] = % shipcrib_upper_catwalk_seca_3_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secA_3_guyB"][0] = % shipcrib_upper_catwalk_seca_3_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secA_4_guyA"][0] = % shipcrib_upper_catwalk_seca_4_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secA_4_guyB"][0] = % shipcrib_upper_catwalk_seca_4_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secA_idle_guyA"][0] = % shipcrib_upper_catwalk_seca_idle_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secA_idle_guyB"][0] = % shipcrib_upper_catwalk_seca_idle_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secB_1_guyA"][0] = % shipcrib_upper_catwalk_secb_1_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secB_1_guyB"][0] = % shipcrib_upper_catwalk_secb_1_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secB_2_guyA"][0] = % shipcrib_upper_catwalk_secb_2_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secB_2_guyB"][0] = % shipcrib_upper_catwalk_secb_2_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secB_3_guyA"][0] = % shipcrib_upper_catwalk_secb_3_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secB_3_guyB"][0] = % shipcrib_upper_catwalk_secb_3_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secB_4_guyA"][0] = % shipcrib_upper_catwalk_secb_4_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secB_4_guyB"][0] = % shipcrib_upper_catwalk_secb_4_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secB_idle_guyA"][0] = % shipcrib_upper_catwalk_secb_idle_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secB_idle_guyB"][0] = % shipcrib_upper_catwalk_secb_idle_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secC_1_guyA"][0] = % shipcrib_upper_catwalk_secc_1_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secC_1_guyB"][0] = % shipcrib_upper_catwalk_secc_1_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secC_2_guyA"][0] = % shipcrib_upper_catwalk_secc_2_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secC_2_guyB"][0] = % shipcrib_upper_catwalk_secc_2_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secC_3_guyA"][0] = % shipcrib_upper_catwalk_secc_3_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secC_3_guyB"][0] = % shipcrib_upper_catwalk_secc_3_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secC_4_guyA"][0] = % shipcrib_upper_catwalk_secc_4_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secC_4_guyB"][0] = % shipcrib_upper_catwalk_secc_4_guyb;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secC_idle_guyA"][0] = % shipcrib_upper_catwalk_secc_idle_guya;
  level._id_EC85["generic"]["shipcrib_upper_catwalk_secC_idle_guyB"][0] = % shipcrib_upper_catwalk_secc_idle_guyb;
  level._id_EC85["generic"]["shipcrib_armory_catwalk_idle_guyA"][0] = % shipcrib_armory_catwalk_idle_guya;
  level._id_EC85["generic"]["shipcrib_armory_catwalk_idle_guyB"][0] = % shipcrib_armory_catwalk_idle_guyb;
  level._id_EC85["generic"]["shipcrib_armory_catwalk_vig_idle_01_guyA"][0] = % shipcrib_armory_catwalk_vig_idle_01_guya;
  level._id_EC85["generic"]["shipcrib_armory_catwalk_vig_idle_01_guyB"][0] = % shipcrib_armory_catwalk_vig_idle_01_guyb;
  level._id_EC85["generic"]["shipcrib_armory_catwalk_vig_idle_02_guyA"][0] = % shipcrib_armory_catwalk_vig_idle_02_guya;
  level._id_EC85["generic"]["shipcrib_armory_catwalk_vig_idle_02_guyB"][0] = % shipcrib_armory_catwalk_vig_idle_02_guyb;
}

_id_DEB9() {
  level._id_EC87["seca_guya"] = #animtree;
  level._id_EC85["seca_guya"]["idle_base"] = % shipcrib_upper_catwalk_seca_idle_guya;
  level._id_EC85["seca_guya"]["idle_anims"] = [%shipcrib_upper_catwalk_seca_1_guya, %shipcrib_upper_catwalk_seca_2_guya, %shipcrib_upper_catwalk_seca_3_guya, %shipcrib_upper_catwalk_seca_4_guya];
  level._id_EC87["seca_guyb"] = #animtree;
  level._id_EC85["seca_guyb"]["idle_base"] = % shipcrib_upper_catwalk_seca_idle_guyb;
  level._id_EC85["seca_guyb"]["idle_anims"] = [%shipcrib_upper_catwalk_seca_1_guyb, %shipcrib_upper_catwalk_seca_2_guyb, %shipcrib_upper_catwalk_seca_3_guyb, %shipcrib_upper_catwalk_seca_4_guyb];
  level._id_EC87["secb_guya"] = #animtree;
  level._id_EC85["secb_guya"]["idle_base"] = % shipcrib_upper_catwalk_secb_idle_guya;
  level._id_EC85["secb_guya"]["idle_anims"] = [%shipcrib_upper_catwalk_secb_1_guya, %shipcrib_upper_catwalk_secb_2_guya, %shipcrib_upper_catwalk_secb_3_guya, %shipcrib_upper_catwalk_secb_4_guya];
  level._id_EC87["secb_guyb"] = #animtree;
  level._id_EC85["secb_guyb"]["idle_base"] = % shipcrib_upper_catwalk_secb_idle_guyb;
  level._id_EC85["secb_guyb"]["idle_anims"] = [%shipcrib_upper_catwalk_secb_1_guyb, %shipcrib_upper_catwalk_secb_2_guyb, %shipcrib_upper_catwalk_secb_3_guyb, %shipcrib_upper_catwalk_secb_4_guyb];
  level._id_EC87["secc_guya"] = #animtree;
  level._id_EC85["secc_guya"]["idle_base"] = % shipcrib_upper_catwalk_secc_idle_guya;
  level._id_EC85["secc_guya"]["idle_anims"] = [%shipcrib_upper_catwalk_secc_1_guya, %shipcrib_upper_catwalk_secc_2_guya, %shipcrib_upper_catwalk_secc_3_guya, %shipcrib_upper_catwalk_secc_4_guya];
  level._id_EC87["secc_guyb"] = #animtree;
  level._id_EC85["secc_guyb"]["idle_base"] = % shipcrib_upper_catwalk_secc_idle_guyb;
  level._id_EC85["secc_guyb"]["idle_anims"] = [%shipcrib_upper_catwalk_secc_1_guyb, %shipcrib_upper_catwalk_secc_2_guyb, %shipcrib_upper_catwalk_secc_3_guyb, %shipcrib_upper_catwalk_secc_4_guyb];
  level._id_EC87["secarmory_guya"] = #animtree;
  level._id_EC85["secarmory_guya"]["idle_base"] = % shipcrib_armory_catwalk_idle_guya;
  level._id_EC85["secarmory_guya"]["idle_anims"] = [%shipcrib_armory_catwalk_vig_idle_01_guya, %shipcrib_armory_catwalk_vig_idle_02_guya];
  level._id_EC87["secarmory_guyb"] = #animtree;
  level._id_EC85["secarmory_guyb"]["idle_base"] = % shipcrib_armory_catwalk_idle_guyb;
  level._id_EC85["secarmory_guyb"]["idle_anims"] = [%shipcrib_armory_catwalk_vig_idle_01_guyb, %shipcrib_armory_catwalk_vig_idle_02_guyb];
}

_id_EB96() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_upper_catwalk_secA", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
  var_1._id_1FBB = "seca_guya";
  var_1._id_1DF6 = var_0;
  var_1 _id_0EFB::_id_FD6F("catwalks_secA");
  var_2 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
  var_2._id_1FBB = "seca_guyb";
  var_2._id_1DF6 = var_0;
  var_2 _id_0EFB::_id_FD6F("catwalks_secA");
  var_0 thread scripts\sp\idles::_id_CC80([var_1, var_2]);
}

_id_EB98() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_upper_catwalk_secB", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
  var_1._id_1FBB = "secb_guya";
  var_1._id_1DF6 = var_0;
  var_1 _id_0EFB::_id_FD6F("catwalks_secB");
  var_2 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
  var_2._id_1FBB = "secb_guyb";
  var_2._id_1DF6 = var_0;
  var_2 _id_0EFB::_id_FD6F("catwalks_secB");
  var_0 thread scripts\sp\idles::_id_CC80([var_1, var_2]);
}

_id_EB99() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_upper_catwalk_secC", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
  var_1._id_1FBB = "secc_guya";
  var_1._id_1DF6 = var_0;
  var_1 _id_0EFB::_id_FD6F("catwalks_secC");
  var_2 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
  var_2._id_1FBB = "secc_guyb";
  var_2._id_1DF6 = var_0;
  var_2 _id_0EFB::_id_FD6F("catwalks_secC");
  var_0 thread scripts\sp\idles::_id_CC80([var_1, var_2]);
}

_id_EB97() {
  var_0 = scripts\engine\utility::getStruct("armory_catwalk_ambient", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "armory_catwalk_ambient", "cheap");
  var_1._id_1FBB = "secarmory_guya";
  var_1._id_1DF6 = var_0;
  var_1 _id_0EFB::_id_FD6F("catwalks_armory");
  var_2 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "armory_catwalk_ambient", "cheap");
  var_2._id_1FBB = "secarmory_guyb";
  var_2._id_1DF6 = var_0;
  var_2 _id_0EFB::_id_FD6F("catwalks_armory");
  var_0 thread scripts\sp\idles::_id_CC80([var_1, var_2]);
}

_id_FDAA() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_hangar_catwalk_idle_d_01", "targetname");
  var_1 = undefined;

  switch (randomint(3)) {
    case 0:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 1:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 2:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
  }

  var_1 _id_0EFB::_id_FD6F("catwalks_sec2B");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_catwalk_idle_d_01");
}

_id_FDA4() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_hangar_catwalk_idle_a_01", "targetname");
  var_1 = undefined;

  switch (randomint(3)) {
    case 0:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 1:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 2:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
  }

  var_1 _id_0EFB::_id_FD6F("catwalks_sec2A");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_catwalk_idle_a_01");
}

_id_FDA5() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_hangar_catwalk_idle_a_02", "targetname");
  var_1 = undefined;

  switch (randomint(3)) {
    case 0:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 1:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 2:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
  }

  var_1 _id_0EFB::_id_FD6F("catwalks_sec2A");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_catwalk_idle_a_02");
}

_id_FDA6() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_hangar_catwalk_idle_b_01", "targetname");
  var_1 = undefined;

  switch (randomint(3)) {
    case 0:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 1:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 2:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
  }

  var_1 _id_0EFB::_id_FD6F("catwalks_sec1A");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_catwalk_idle_b_01");
}

_id_FDA7() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_hangar_catwalk_idle_b_02", "targetname");
  var_1 = undefined;

  switch (randomint(3)) {
    case 0:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 1:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 2:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
  }

  var_1 _id_0EFB::_id_FD6F("catwalks_sec1A");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_catwalk_idle_b_02");
}

_id_FDA8() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_hangar_catwalk_idle_c_01", "targetname");
  var_1 = undefined;

  switch (randomint(3)) {
    case 0:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 1:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 2:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
  }

  var_1 _id_0EFB::_id_FD6F("catwalks_sec1B");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_catwalk_idle_c_01");
}

_id_FDA9() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_hangar_catwalk_idle_c_02", "targetname");
  var_1 = undefined;

  switch (randomint(3)) {
    case 0:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 1:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 2:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
  }

  var_1 _id_0EFB::_id_FD6F("catwalks_sec1B");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_catwalk_idle_c_02");
}

_id_FDA3() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_hangar_catwalk_idle_a2_01", "targetname");
  var_1 = undefined;

  switch (randomint(3)) {
    case 0:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 1:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
    case 2:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "shipcrib_hangar_catwalk_idle_d_01", "cheap");
      break;
  }

  var_1 _id_0EFB::_id_FD6F("catwalks_sec3A");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_catwalk_idle_a_01");
}

_id_FDAB() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_hangar_lower_jackal_catwalk_02", "targetname");
  var_1 = undefined;

  switch (randomint(3)) {
    case 0:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_lower_jackal_catwalk_02", "cheap");
      break;
    case 1:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "shipcrib_hangar_lower_jackal_catwalk_02", "cheap");
      break;
    case 2:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "shipcrib_hangar_lower_jackal_catwalk_02", "cheap");
      break;
  }

  var_1 _id_0EFB::_id_FD6F("catwalks_sec2B");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_lower_jackal_catwalk_02");
}

_id_FDAC() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_hangar_lower_jackal_catwalk_03", "targetname");
  var_1 = undefined;

  switch (randomint(3)) {
    case 0:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_lower_jackal_catwalk_03", "cheap");
      break;
    case 1:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "shipcrib_hangar_lower_jackal_catwalk_03", "cheap");
      break;
    case 2:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "shipcrib_hangar_lower_jackal_catwalk_03", "cheap");
      break;
  }

  var_1 _id_0EFB::_id_FD6F("catwalks_sec3B");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_lower_jackal_catwalk_03");
}

_id_FDAD() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_hangar_lower_jackal_catwalk_05", "targetname");
  var_1 = undefined;

  switch (randomint(3)) {
    case 0:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "shipcrib_hangar_lower_jackal_catwalk_05", "cheap");
      break;
    case 1:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "shipcrib_hangar_lower_jackal_catwalk_05", "cheap");
      break;
    case 2:
      var_1 = _id_0EF8::_id_FE01("spawner_flightdeck_ordnance", "shipcrib_hangar_lower_jackal_catwalk_05", "cheap");
      break;
  }

  var_1 _id_0EFB::_id_FD6F("catwalks_sec1B");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "shipcrib_hangar_lower_jackal_catwalk_05");
}