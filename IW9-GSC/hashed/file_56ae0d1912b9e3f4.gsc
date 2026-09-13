/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_56ae0d1912b9e3f4.gsc
***********************************************/

_id_A16EC5DE7F7D53EB(_id_F41560E9F2BC195E) {
  scripts\cp\utility::coop_mode_enable();
  _id_D525F1534752BFC7();
  _id_2CFEF434CE6A1C44();
  _id_279964C2C969DDA3();
  _id_3861EB0A004E0D38();
  _id_C4D555BF9485AC3B();
  _id_E0125729CABDA438();
  level._id_B335AC3B1F30362F = &"CP_MISSION_DEFENDER/TUTORIAL_LONE";
  level._id_364C64AC310725A0 = 0;
  level._id_5627D6C50B64EFCD = ::_id_15D8E2B3B6EED007;
  level._id_A90AED074077E2B0 = _id_7F707E7E596495AE::_id_7AFC5B8F74443ABA;
  level._id_898575DB3C10AC91 = _id_7F707E7E596495AE::_id_091EF3AA2C696B6F;
  level._id_422E732809F58989 = _id_78AB8FD7A727A17F::_id_69BFE249A6C9349D;
  level.get_mortar_impact_pos = _id_1685E6D8181C932A::_id_AA2345159B60A661;
  level._id_96D46B3DE782E4E7 = 512;
  level._id_884F3D8344C4EAFE = 1;
  level._id_C59C301EAABC2E32 = 1;
  level._id_D2AE25FA1777E73D = ::_id_9CAAFA853E29E69E;
  level._id_5D9392255ABBFD4E = ::_id_A133E98002436CB2;
  level._id_E16F8BE936AE77A5 = ::_id_BAFFF60BC18C500C;
  level._id_54F48A7236A6DD69 = ::_id_14AD2410A9A3B8EB;
  level._id_07DEE064EF025310 = 1500;
  level._id_E3FA08A0EE652BFE = 500;
  level._id_364C64AC310725A0 = 1;
  thread scripts\cp\intel\cp_intel::intel_init();
}

_id_BED05BB8326E8CC3() {
  id = _id_F08D890C58AE12BC((-43902, -22462, 520), 200, 300, 128, (0, 0, 0));
  id = _id_F08D890C58AE12BC((-45024, -22180, 520), 200, 300, 128, (0, 0, 0));
}

_id_F08D890C58AE12BC(origin, x, y, z, angles, team) {
  if(isDefined(team))
    navobstacle = createnavobstaclebybounds(origin, (x, y, z), angles, team);
  else
    navobstacle = createnavobstaclebybounds(origin, (x, y, z), angles);

  return navobstacle;
}

_id_9CAAFA853E29E69E() {
  return _id_7AF29C0D11278DBA::_id_0D80EE6CCE6D911A();
}

_id_A133E98002436CB2() {
  _id_AA82E6D1B3760575 = level._id_62F5F42C7C300055 * 10;
  _id_39CF0DFC43581EBB = 0;

  if(level._id_62F5F42C7C300055 == 1) {} else if(level._id_62F5F42C7C300055 == 2) {
    _id_AA82E6D1B3760575 = 40;

    if(isDefined(level._id_2B218E6AEBB46057))
      _id_39CF0DFC43581EBB = level._id_2B218E6AEBB46057.size;
  } else if(level._id_62F5F42C7C300055 == 3) {
    _id_AA82E6D1B3760575 = 90;

    if(isDefined(level._id_11A368973DB314CA))
      _id_39CF0DFC43581EBB = 1;
    else
      _id_39CF0DFC43581EBB = 0;
  } else if(level._id_62F5F42C7C300055 == 4) {
    _id_AA82E6D1B3760575 = 60;
    _id_A00FE886E805DF48 = [];
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    foreach(guy in guys) {
      if(guy _id_18A73A64992DD07D::is_specified_unittype("juggernaut"))
        _id_A00FE886E805DF48 = scripts\engine\utility::array_add(_id_A00FE886E805DF48, guy);
    }

    _id_39CF0DFC43581EBB = _id_A00FE886E805DF48.size;
  } else if(level._id_62F5F42C7C300055 == 5) {
    _id_AA82E6D1B3760575 = 50;
    _id_A00FE886E805DF48 = [];
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    foreach(guy in guys) {
      if(istrue(guy.hasriotshieldequipped) || istrue(guy.bhasriotshieldattached))
        _id_A00FE886E805DF48 = scripts\engine\utility::array_add(_id_A00FE886E805DF48, guy);
    }

    _id_39CF0DFC43581EBB = _id_A00FE886E805DF48.size;
  } else if(level._id_62F5F42C7C300055 == 6) {
    _id_AA82E6D1B3760575 = 80;
    _id_A00FE886E805DF48 = [];
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    foreach(guy in guys) {
      if(guy.aitype == "boss_velikan")
        _id_A00FE886E805DF48 = scripts\engine\utility::array_add(_id_A00FE886E805DF48, guy);
    }

    _id_39CF0DFC43581EBB = _id_A00FE886E805DF48.size;
  }

  value = _id_AA82E6D1B3760575 + _id_39CF0DFC43581EBB;
  setomnvar("cp_enemies_special", value);
}

_id_41B09657BD12487B(_id_F91E0918144A746E) {
  items = strtok(_id_F91E0918144A746E, "_");
  _id_ED553C0E628507CB = strtok(_id_F91E0918144A746E, "-");
  params = strtok(_id_F91E0918144A746E, "&");
  player = undefined;

  if(_id_ED553C0E628507CB.size > 1) {
    _id_992D4A4D67CE8BA5 = int(_id_ED553C0E628507CB[0]);
    player = level.players[_id_992D4A4D67CE8BA5];
  }

  if(isDefined(_id_F91E0918144A746E)) {
    switch (_id_F91E0918144A746E) {
      case "reset":
        level._id_55A09C394B278F7E = [];
        break;
      default:
        level._id_55A09C394B278F7E = scripts\engine\utility::array_add_safe(level._id_55A09C394B278F7E, _id_F91E0918144A746E);
        break;
    }
  }
}

_id_411429D963C551D1(_id_F91E0918144A746E) {
  items = strtok(_id_F91E0918144A746E, "_");
  _id_ED553C0E628507CB = strtok(_id_F91E0918144A746E, "-");
  params = strtok(_id_F91E0918144A746E, "&");
  player = undefined;

  if(_id_ED553C0E628507CB.size > 1) {
    _id_992D4A4D67CE8BA5 = int(_id_ED553C0E628507CB[0]);
    player = level.players[_id_992D4A4D67CE8BA5];
  }

  if(isDefined(_id_F91E0918144A746E)) {
    _id_F91E0918144A746E = tolower(_id_F91E0918144A746E);

    switch (_id_F91E0918144A746E) {
      case "reset":
        level._id_1CBC4B8EA6561585 = [];
        break;
      default:
        level._id_1CBC4B8EA6561585 = scripts\engine\utility::array_add_safe(level._id_1CBC4B8EA6561585, _id_F91E0918144A746E);
        break;
    }
  }
}

_id_B906343692F1FAC4(_id_F91E0918144A746E) {
  if(isDefined(level._id_824802C9291AB2EB))
    level._id_824802C9291AB2EB notify("trigger", level.players[0]);
}

_id_EA8084BE6F8A2CF9() {
  scripts\engine\utility::flag_wait("level_ready_for_script");

  if(getdvarint("dvar_16C27BD9C165F4D6")) {
    return;
  }
  if(scripts\cp\cp_relics::_id_30D732F612695BA8()) {
    return;
  }
  _id_DBBAD27C597E2131 = getEntArray("ammo_refill_station", "targetname");

  foreach(_id_B1E7DB85E79AD378 in _id_DBBAD27C597E2131)
  _id_B1E7DB85E79AD378.nav_obstacle = createnavobstaclebybounds(_id_B1E7DB85E79AD378.origin, (20, 25, 27), _id_B1E7DB85E79AD378.angles);

  _id_CDE2EC78F52F00F9 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike4");
  _id_CDE2EC78F52F00F9 = _id_CDE2EC78F52F00F9 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["hybrid"]);
  _id_CDE2EC78F52F00F9 = _id_CDE2EC78F52F00F9 _meth_ 1 BD5B3BEF3D9A61(["grip_vertshort02", "bar_ar_short_p01_mike4"]);
  _id_CDE2EA78F52EFC93 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mcharlie");
  _id_CDE2EA78F52EFC93 = _id_CDE2EA78F52EFC93 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["minireddot06", "grip_angled"]);
  _id_CDE2EF78F52F0792 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("india");
  _id_CDE2EF78F52F0792 = _id_CDE2EF78F52F0792 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["flash_dm_04"]);
  _id_CDE2F078F52F09C5 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("akilo");
  _id_CDE2ED78F52F032C = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("papa220");
  _id_CDE2ED78F52F032C = _id_CDE2ED78F52F032C _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["mag_pi_large_p27", "trigger_hair_p27", "reddot", "comp_pi_02", "pgrip_ass_p27"]);
  _id_CDE2EE78F52F055F = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("ngolf7");
  _id_CDE2EE78F52F055F = _id_CDE2EE78F52F055F _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["hybrid"]);
  _id_CDE2F378F52F105E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("alpha57");
  _id_CDE2F378F52F105E = _id_CDE2F378F52F105E _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["minireddot", "grip_vertshort"]);
  _id_CDE2F478F52F1291 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike14");
  _id_CDE2F478F52F1291 = _id_CDE2F478F52F1291 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holo"]);
  _id_CDE2F478F52F1291 = _id_CDE2F478F52F1291 _meth_ 1 BD5B3BEF3D9A61(["stock_dm_light_p18_mike14", "mag_sn_large_p18", "hybrid03"]);
  _id_F90ED703365EBA0B = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("mike1014");
  _id_F90ED703365EBA0B = _id_F90ED703365EBA0B _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["grip_angled", "ammo_12g_db_mike1014", "bolt_lgt_p12", "breacher_sh_01"]);
  _id_F90ED603365EB7D8 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("victor");
  _id_F90ED603365EB7D8 = _id_F90ED603365EB7D8 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["minireddot", "grip_angled"]);
  _id_F90ED603365EB7D8 = _id_F90ED603365EB7D8 _meth_ 1 BD5B3BEF3D9A61(["drum_p10", "bar_sm_lgtshort_p10"]);
  _id_F90ED903365EBE71 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("schotel");
  _id_F90ED903365EBE71 = _id_F90ED903365EBE71 _id_74502A9E0EF1F19C::_id_DCB52BCBBCB80B00(["holorange", "grip_vertshort"]);
  _id_F90ED803365EBC3E = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("gromeo");
  _id_F90EDB03365EC2D7 = _id_74502A9E0EF1F19C::_id_768C9A047AED19F4("kgolf");
  _id_A13FD508CAD5931C = scripts\engine\utility::getStructArray("weapon_wall", "targetname");

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A13FD508CAD5931C.size; _id_AC0E594AC96AA3A8++) {
    _id_28A6B68460F4FD6B = _id_A13FD508CAD5931C[_id_AC0E594AC96AA3A8];
    weapon_object = undefined;

    if(!isDefined(_id_28A6B68460F4FD6B.weaponinfo)) {
      continue;
    }
    switch (_id_28A6B68460F4FD6B.weaponinfo) {
      case "weapon_wm_ar_mike4_brprop":
        weapon_object = _id_CDE2EC78F52F00F9;
        break;
      case "weapon_wm_sn_sbeta_brprop":
        weapon_object = _id_CDE2F478F52F1291;
        break;
      case "weapon_wm_sn_mike14_brprop":
        weapon_object = _id_CDE2EA78F52EFC93;
        break;
      case "weapon_wm_sn_alpha50_brprop":
        weapon_object = _id_CDE2EF78F52F0792;
        break;
      case "weapon_wm_ar_akilo47_brprop":
        weapon_object = _id_CDE2F078F52F09C5;
        break;
      case "weapon_wm_pi_mike1911_brprop":
        weapon_object = _id_CDE2ED78F52F032C;
        break;
      case "weapon_wm_lm_kilo121_brprop":
        weapon_object = _id_CDE2EE78F52F055F;
        break;
      case "weapon_wm_sm_mpapa5_brprop":
        weapon_object = _id_CDE2F378F52F105E;
        break;
      case "weapon_wm_sm_beta_brprop":
        weapon_object = _id_CDE2F478F52F1291;
        break;
      case "weapon_wm_sh_charlie725_brprop":
        weapon_object = _id_F90ED703365EBA0B;
        break;
      case "weapon_wm_sm_mpapa7_brprop":
        weapon_object = _id_F90ED603365EB7D8;
        break;
      case "weapon_wm_ar_kilo433_brprop":
        weapon_object = _id_F90ED903365EBE71;
        break;
      case "weapon_wm_la_rpapa7":
        weapon_object = _id_F90ED803365EBC3E;
        break;
      case "weapon_wm_la_kgolf_brprop":
        weapon_object = _id_F90EDB03365EC2D7;
        break;
    }

    if(isDefined(weapon_object)) {
      _id_28A6B68460F4FD6B _id_3E19322333AD204C::_id_9655BF427A5ABDB8(undefined, weapon_object);
      continue;
    }
  }

  level thread _id_3E19322333AD204C::_id_F0DB4DDA6F417EA1();
  scripts\cp\utility::_id_C0D2C91F2688ECE4(1);
}

_id_87F2B152CF408D59(_id_28A6B68460F4FD6B, weapon_object) {
  level endon("game_ended");

  for(;;) {
    _id_C00805D2E42B3456 = _id_28A6B68460F4FD6B _id_3E19322333AD204C::_id_9655BF427A5ABDB8(undefined, weapon_object);
    _id_C00805D2E42B3456 _id_66122A002AFF5D57::_id_86321FC8F45C2A9B(0);
    _id_C00805D2E42B3456 _id_66122A002AFF5D57::_id_B10EE40ED82D45C9(1);

    while(isDefined(_id_C00805D2E42B3456))
      waitframe();
  }
}

_id_15D8E2B3B6EED007() {
  level._id_215CD837F06FA79E._id_94E26D3F1E7B9449 = [];
  _id_A2B11613E4C46ED8 = 1;
  level._id_215CD837F06FA79E._id_69714C701D381A31[_id_A2B11613E4C46ED8] = 1;
  level._id_215CD837F06FA79E._id_DEF74253F2C565A1[_id_A2B11613E4C46ED8] = ["medium_close", 1, "soldier", 4, "soldier", 8, "medium", 4, "medium"];
  level._id_215CD837F06FA79E._id_AC09429F0F9FF18F[_id_A2B11613E4C46ED8] = "Wave One: Counter-attack.";
  _id_1985BEABA5E12B38::_id_23B61F49117D9DBE();
  _id_A2B11613E4C46ED8 = 2;
  level._id_215CD837F06FA79E._id_69714C701D381A31[_id_A2B11613E4C46ED8] = 1;
  level._id_215CD837F06FA79E._id_DEF74253F2C565A1[_id_A2B11613E4C46ED8] = ["soldier", 1, "mortar", 5, "mortar", 15, "medium", 5, "soldier", 15, "medium", 1];
  level._id_215CD837F06FA79E._id_BE6E74B71830F399[_id_A2B11613E4C46ED8] = 1500;
  level._id_215CD837F06FA79E._id_AC09429F0F9FF18F[_id_A2B11613E4C46ED8] = "Wave Three: Mortar.";
  _id_A2B11613E4C46ED8 = 3;
  level._id_215CD837F06FA79E._id_69714C701D381A31[_id_A2B11613E4C46ED8] = 2;
  level._id_215CD837F06FA79E._id_DEF74253F2C565A1[_id_A2B11613E4C46ED8] = ["heli_heavy", 1, "soldier", 1, "soldier", 15];
  level._id_215CD837F06FA79E._id_BE6E74B71830F399[_id_A2B11613E4C46ED8] = 1500;
  level._id_215CD837F06FA79E._id_AC09429F0F9FF18F[_id_A2B11613E4C46ED8] = "Wave Six: Attack Helicopter.";
  _id_A2B11613E4C46ED8 = 4;
  level._id_215CD837F06FA79E._id_69714C701D381A31[_id_A2B11613E4C46ED8] = 2;
  level._id_215CD837F06FA79E._id_DEF74253F2C565A1[_id_A2B11613E4C46ED8] = ["juggernaut", 2, "soldier", 1, "medium", 3, "juggernaut", 25, "medium", 15];
  level._id_215CD837F06FA79E._id_BE6E74B71830F399[_id_A2B11613E4C46ED8] = 1500;
  level._id_215CD837F06FA79E._id_AC09429F0F9FF18F[_id_A2B11613E4C46ED8] = "Wave Five: Juggernaut.";
  level._id_215CD837F06FA79E._id_4757143D8FD7202C[_id_A2B11613E4C46ED8] = 5;
  _id_A2B11613E4C46ED8 = 5;
  level._id_215CD837F06FA79E._id_69714C701D381A31[_id_A2B11613E4C46ED8] = 2;
  level._id_215CD837F06FA79E._id_DEF74253F2C565A1[_id_A2B11613E4C46ED8] = ["riotshield", 1, "riotshield", 15, "soldier", 1, "soldier", 10];
  level._id_215CD837F06FA79E._id_BE6E74B71830F399[_id_A2B11613E4C46ED8] = 1500;
  level._id_215CD837F06FA79E._id_AC09429F0F9FF18F[_id_A2B11613E4C46ED8] = "Wave Two: Shields.";
  level._id_215CD837F06FA79E._id_D97C715A28AB9260[_id_A2B11613E4C46ED8] = "smoke_grenade_mp";
  level._id_215CD837F06FA79E._id_4757143D8FD7202C[_id_A2B11613E4C46ED8] = 8;
  _id_A2B11613E4C46ED8 = 6;
  level._id_215CD837F06FA79E._id_69714C701D381A31[_id_A2B11613E4C46ED8] = 3;
  level._id_215CD837F06FA79E._id_DEF74253F2C565A1[_id_A2B11613E4C46ED8] = ["medium", 3, "soldier", 5, "medium_close", 1, "velikan_small", 1];
  level._id_215CD837F06FA79E._id_BE6E74B71830F399[_id_A2B11613E4C46ED8] = 1500;
  level._id_215CD837F06FA79E._id_AC09429F0F9FF18F[_id_A2B11613E4C46ED8] = "Wave Four: Velikan.";
  level._id_215CD837F06FA79E._id_4757143D8FD7202C[_id_A2B11613E4C46ED8] = 12;
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_B773758221A0C100", 7, 15);
  level.outofboundstime = 7;
  level._id_ED42A79A82EED1E4 = 1;
  level._id_215CD837F06FA79E._id_B4703EA502094BC1 = 999;
  level._id_215CD837F06FA79E._id_C014A8B31EFCFF70 = 30;
}

_id_23ABD769445A0A5C(_id_F96E9372BF4D85EB, _id_A2B11613E4C46ED8, aitype, _id_1431EF8F070DE8F8, _id_418FF0EC96141CB7) {
  if(isDefined(level._id_215CD837F06FA79E._id_94E26D3F1E7B9449) && isDefined(level._id_215CD837F06FA79E._id_94E26D3F1E7B9449[_id_F96E9372BF4D85EB]) && isDefined(level._id_215CD837F06FA79E._id_94E26D3F1E7B9449[_id_F96E9372BF4D85EB][_id_A2B11613E4C46ED8]))
    level._id_215CD837F06FA79E._id_94E26D3F1E7B9449[_id_F96E9372BF4D85EB][_id_A2B11613E4C46ED8] = scripts\engine\utility::array_combine(level._id_215CD837F06FA79E._id_94E26D3F1E7B9449[_id_F96E9372BF4D85EB][_id_A2B11613E4C46ED8], [aitype, _id_1431EF8F070DE8F8]);
  else
    level._id_215CD837F06FA79E._id_94E26D3F1E7B9449[_id_F96E9372BF4D85EB][_id_A2B11613E4C46ED8] = [aitype, _id_1431EF8F070DE8F8];
}

_id_633EE74E2649AAC7(_id_97282C14346A7FCF) {
  level._id_0F3D1630DE429691 = 1;
  setDvar("start", "defender_infil");
  scripts\cp\cp_checkpoint::checkpoint_set("");
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
}

_id_F2220F29B3639954() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 0, 0);
  thread _id_075E58DC9392EEE8::_id_6E0DA54E3DBFD74F();
  level thread _id_3E19322333AD204C::main();
}

_id_BEC3302A49F19844() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 0, 0);
  level thread _id_3E19322333AD204C::main();
}

_id_AC10774E24A6A3DE() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
  level thread _id_3E19322333AD204C::main();
}

_id_AC10764E24A6A1AB() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
  level._id_51444070C494BD3E = 2;
  level thread _id_3E19322333AD204C::main();
}

_id_AC10754E24A69F78() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
  level._id_51444070C494BD3E = 3;
  level thread _id_3E19322333AD204C::main();
}

_id_AC107C4E24A6AEDD() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
  level._id_51444070C494BD3E = 4;
  level thread _id_3E19322333AD204C::main();
}

_id_AC107B4E24A6ACAA() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
  level._id_51444070C494BD3E = 5;
  level thread _id_3E19322333AD204C::main();
}

_id_AC107A4E24A6AA77() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
  level._id_51444070C494BD3E = 6;
  level thread _id_3E19322333AD204C::main();
}

_id_A3DB32CB6503E9B1() {
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_8169ECBE42B9A407", 1, 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_7D7E0BBD84A4488F", 1, 0);
  scripts\cp\challenges_cp::_id_51BBBA3794076BF4();
  level._id_51444070C494BD3E = 7;
  level thread _id_3E19322333AD204C::main();
}

_id_2CFEF434CE6A1C44() {
  level scripts\cp\utility\spawn_event_aggregator::registeronplayerspawncallback(::onplayerspawned);
  level _id_14609B809484646E::_id_8ECE37593311858A(::onplayerconnect);
}

onplayerconnect() {}

onplayerspawned() {
  thread _id_19A7DFA4CBC97660();
  thread _id_0D69ABE4F7DE7B02();

  if(scripts\cp\cp_relics::_id_7380668EAB6114E9())
    thread _id_85FD2E2DF090C9E9();
}

_id_85FD2E2DF090C9E9() {
  waitframe();
  _id_66122A002AFF5D57::takeweaponsdefaultfunc("iw9_me_fists_mp");
}

_id_0D69ABE4F7DE7B02() {
  level endon("game_ended");
  self endon("disconnect");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");

  if(!_id_075E58DC9392EEE8::_id_F97A8F50CC4EB6DF()) {
    if(!isDefined(self.minimapstatetracker) || self.minimapstatetracker == 0)
      thread scripts\cp\utility::showminimap();
  }
}

_id_19A7DFA4CBC97660() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  thread _id_AEA7DA12F40E5C07();
  wait 1;
  _id_07C40FA80892A721::givestartingarmor(100);

  if(!scripts\cp\cp_relics::_id_30D732F612695BA8()) {
    foreach(weapon in self.weaponlist) {
      clip_ammo = weaponclipsize(weapon);
      self setweaponammoclip(weapon, clip_ammo);
      _id_66122A002AFF5D57::_id_4172A10AE7CBDB41(weapon);
    }
  }
}

_id_4CAA43744BFB73BD() {
  level endon("game_ended");

  if(isDefined(level._id_4CAA43744BFB73BD)) {
    return;
  }
  level._id_4CAA43744BFB73BD = 1;

  while(scripts\cp\utility::_id_95E3A48DBAF38216())
    wait 0.1;

  level thread scripts\cp\utility::play_music_to_team("mx_cp_lone_infil");
}

_id_AEA7DA12F40E5C07() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  if(!_id_075E58DC9392EEE8::_id_F97A8F50CC4EB6DF()) {
    if(!isDefined(game["completed_defender_intro"]))
      level thread _id_4CAA43744BFB73BD();

    return;
  }

  thread _id_2AC51289F1C7B5E8();
  _id_075E58DC9392EEE8::_id_9B96DA45D4997EA6();
  _id_075E58DC9392EEE8::_id_EE497CACCCDD57FB(level._id_6E0DA54E3DBFD74F);

  if(level._id_6E0DA54E3DBFD74F scripts\engine\utility::ent_flag("infil_started")) {
    _id_075E58DC9392EEE8::_id_4AEF5B543EE8765B(level._id_6E0DA54E3DBFD74F);
    self allowmovement(0);
    level._id_6E0DA54E3DBFD74F scripts\engine\utility::ent_flag_wait("infil_stopped");
    self allowmovement(1);
  } else
    _id_075E58DC9392EEE8::_id_FBB85F00D28DEC1D(level._id_6E0DA54E3DBFD74F);

  _id_075E58DC9392EEE8::_id_7DA864E4D4F3FDAC();
}

_id_2AC51289F1C7B5E8() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  scripts\engine\utility::ent_flag_wait("intro_binks_complete");
  scripts\cp\utility::hideminimap(1);
  _id_787CD713CCF77036(0);
  scripts\cp\utility::_id_4CBAED764C116A25(1);
  scripts\cp\utility\player::hidehudenable();
  _id_3B64EB40368C1450::_id_59C053B89257BC95("van_infil", ["fire", "sprint", "supersprint", "offhand_primary_weapons", "offhand_secondary_weapons", "weapon_switch"], 0);
  level._id_6E0DA54E3DBFD74F scripts\engine\utility::ent_flag_wait("infil_stopped");
  scripts\cp\utility::showminimap();
  _id_787CD713CCF77036(1);
  scripts\cp\utility::_id_4CBAED764C116A25(0);
  scripts\cp\utility\player::hidehuddisable();

  if(scripts\cp\cp_relics::_id_7380668EAB6114E9())
    thread scripts\cp\cp_hud_message::tutorialprint(&"COOP_GAME_PLAY/CHARGE_JUMP_MESSAGE", 12);

  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("van_infil");
  self allowmovement(1);
}

_id_787CD713CCF77036(_id_EE5E6678C3E67777) {
  if(_id_EE5E6678C3E67777) {
    self setclientomnvar("ui_hide_bigmap", 0);
    self setclientomnvar("ui_show_tac_map", 1);
  } else {
    self setclientomnvar("ui_hide_bigmap", 1);
    self setclientomnvar("ui_show_tac_map", 0);
  }
}

_id_BC3FA9E472A01E1A(_id_86DB2022C4F0F4BF, _id_185EA69B2FE37360, _id_7CB3CE39E2414126, _id_9B02313FE7FF70DA) {
  if(istrue(self._id_A1E9B37782A5D8D8)) {
    return;
  }
  _id_7EF95BBA57DC4B82::_id_707926E6CE8DDC60("primary", level._id_377071435EDF746D);
  _id_7EF95BBA57DC4B82::_id_707926E6CE8DDC60("secondary", level._id_1126CD09894FF2E1);
  self._id_A1E9B37782A5D8D8 = 1;
}

_id_279964C2C969DDA3() {
  level.dogtag_revive = 0;
}

_id_3861EB0A004E0D38() {
  level.objectivesfunc = ::_id_C2A86F682BF1AB71;
  level thread scripts\cp\cp_objectives::objectives_init();
}

_id_C4D555BF9485AC3B() {
  _id_BED05BB8326E8CC3();
  level._id_633EE74E2649AAC7 = ::_id_633EE74E2649AAC7;
  _id_266C399FB76E6719::register_aitype_setup("ally_mex_ar", "iw9_ally_mex_sf_ar_cp");
  _id_266C399FB76E6719::register_aitype_setup("ally_mex_dmr", "iw9_ally_mex_sf_dmr_cp");
  _id_266C399FB76E6719::register_aitype_setup("ally_mex_smg", "iw9_ally_mex_sf_smg_cp");
  _id_678ADBED602DA5EB::_id_BCE89A6DE8A052AF();
  setup_create_script();
  level._id_8538329F94B9C271 = "cp_lone_defender_2";
  level._id_377071435EDF746D = 3;
  level._id_1126CD09894FF2E1 = 3;
  level._id_5966C39CB60075F1 = ::_id_BC3FA9E472A01E1A;
  level._id_7EA1A9DB4C78BE14 = ::_id_7EA1A9DB4C78BE14;
  _id_1E22D314CC16F807::_id_A133C2FF48B59DD7("scripted");
  _id_12E2FB553EC1605E::_id_B82B35CA0F5529AA(0);
  _id_12E2FB553EC1605E::_id_E2D370937C694C58("iw9_ar_acharlie300_mp", ["reflex02_tall", "grip_vertshort02", "bar_ar_long_p43"], "iw9_pi_golf18_mp", ["iw9_minireddot05_pstl", "pgrip_tac", "mag_pi_large_p24"]);
  _id_12E2FB553EC1605E::_id_EBF2582B122904FC("equip_frag", "equip_flash");
  level thread _id_FC4803DC319A81D2();
  scripts\cp\cp_compass::setupminimap("compass_map_cp_lone", 2);
  _id_3982EF63C578E857::_id_B04F37F19C6631E0();
  _id_780514F14B1134ED::_id_957D3897064478FF();
  level thread scripts\cp\cp_objectives::run_debug_start_objective();
  level thread _id_7F3DCDD10D9F4895::main();
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender", "choose_hardpoint", ::_id_F58E082D627F3645);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender", "choose_hardpoint_label", ::_id_1C616353D73DC331);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender", "choose_ordering_array", ::_id_91E328822ACF8E4B);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender", "soldier_isolated_killoff", ::_id_B29F7CB5173B7D78);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender", "mortar_team_area_think", ::_id_A654C6DED67DA339);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender", "attackgroup_handle_spawns", ::_id_F76C8BF80E927543);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender", "aitype_type_validation", ::_id_C56D8CFD3E89AEBE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("binks", "binksExitFunc", ::_id_EEEB3E1DAAFBD9D6);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender_vo", "wave_incoming", _id_6D7723FE67D5EAF1::_id_FF706C28066E3A3F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender_vo", "point_clear", _id_6D7723FE67D5EAF1::_id_619CC5C01A10AA61);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender_vo", "allies_deploy", _id_6D7723FE67D5EAF1::_id_CD3408D8B63EB759);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender_vo", "allies_down", _id_6D7723FE67D5EAF1::_id_AA913252BFCB4AB2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender_vo", "enemy_casualties", _id_6D7723FE67D5EAF1::_id_B1EA54B920AFA6F0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender_vo", "few_enemies_remain", _id_6D7723FE67D5EAF1::_id_7CA559AEE8BBFD61);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender_vo", "bomb_planted", _id_6D7723FE67D5EAF1::_id_A88C781E5EA4CFB8);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender_vo", "bomb_defused", _id_6D7723FE67D5EAF1::_id_5994EB14C59DD582);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender_vo", "bomb_exploded", _id_6D7723FE67D5EAF1::_id_F268432F3BC3718F);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender_vo", "bomb_timer", _id_6D7723FE67D5EAF1::_id_92A3B85D5A08EC5D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender_vo", "item_purchased", _id_6D7723FE67D5EAF1::_id_D28A3C1951CB2D9D);
  scripts\cp_mp\utility\script_utility::registersharedfunc("defender_vo", "outro", _id_6D7723FE67D5EAF1::_id_6E684EA81094C86E);
  level thread _id_EA8084BE6F8A2CF9();
}

_id_EEEB3E1DAAFBD9D6() {
  self endon("disconnect");
  level endon("game_ended");
  level._id_F897D54E1C59990C = scripts\engine\utility::array_remove(level._id_F897D54E1C59990C, self);

  if(level._id_F897D54E1C59990C.size > 0) {
    thread _id_0598E0C00C8151F7::_id_4A89B0747EF8CBAE();

    while(level._id_F897D54E1C59990C.size > 0)
      waitframe();
  }

  self._id_4B668A8CB58C3B0E = _id_0598E0C00C8151F7::_id_20C2A39E2AED32AA();
  scripts\engine\utility::ent_flag_set("intro_binks_complete");
  self setclientomnvar("ui_vote_results", 0);
  scripts\cp\utility::_id_4CBAED764C116A25(0);
  scripts\cp\utility::allow_player_ignore_me(0);
  scripts\cp\utility::freezecontrolswrapper(0);
  thread scripts\cp_mp\utility\game_utility::_id_852712268D005332(self, 0, 2);
  scripts\cp\utility::hideminimap(0);
  self setclientomnvar("ui_hide_hud", 0);
  self setclientomnvar("ui_hide_bigmap", 0);
  self setclientomnvar("ui_show_tac_map", 1);
  _id_3B64EB40368C1450::_id_3633B947164BE4F3("gameEndFreeze", 1);
  _id_116171939929AF39::refreshuimatchinprogressomnvarvalue();
  self clearclienttriggeraudiozone(0);
  scripts\engine\utility::flag_set("intro_binks_complete");
  game["has_seen_binks"] = 1;
  scripts\engine\utility::flag_set("both_players_intro_binks_complete");
}

_id_C56D8CFD3E89AEBE(spawnpoint, _id_F8E5E3AA5762A8E7, _id_E75102F384565FCF) {}

_id_7EA1A9DB4C78BE14(ref, slot) {
  if(isDefined(slot)) {
    if(slot == "primary" && isDefined(level._id_377071435EDF746D)) {
      _id_A5801084C24535F9 = 0;

      if(scripts\cp\utility::_hasperk("specialty_extra_deadly") && slot == "primary")
        _id_A5801084C24535F9 = 1;

      return level._id_377071435EDF746D + _id_A5801084C24535F9;
    } else if(slot == "secondary" && isDefined(level._id_1126CD09894FF2E1)) {
      _id_A5801084C24535F9 = 0;

      if(scripts\cp\utility::_hasperk("specialty_extra_tactical") && slot == "secondary")
        _id_A5801084C24535F9 = 1;

      return level._id_1126CD09894FF2E1 + _id_A5801084C24535F9;
    } else
      return undefined;
  } else
    return undefined;
}

_id_E0125729CABDA438() {
  _id_6FBA7DF440C493C4::init_vehicles();
  _id_0E80538EF14D00E1::register_combined_vehicles(scripts\vehicle\techo::main, "veh8_civ_lnd_techo_rebel_physics", "veh9_techo_physics_cp", "script_vehicle_iw9_truck_techo_rebel", undefined, "techo_ai", "techo_ai");
  _id_0E80538EF14D00E1::register_combined_vehicles(_id_3AF63BEEAAB2E0A7::main, "veh9_civ_lnd_techo_rebel_armor_vehphys_cp", "veh9_techo_physics_cp", "script_vehicle_iw9_truck_techo_rebel_armor", undefined, "techo_ai_armor", "techo_ai_armor");
  _id_0E80538EF14D00E1::register_combined_vehicles(scripts\vehicle\lbravo::main, "veh8_mil_air_lbravo_personnel_cp", "lbravo_infil_cp", "script_vehicle_iw8_lbravo_carrier", undefined, "lbravo_carrier_hover", "lbravo_carrier_hover");
  _id_0E80538EF14D00E1::register_combined_vehicles(_id_516851C4CA47F492::main, "veh9_mil_air_heli_medium_vehphys_mp", "veh9_mil_air_heli_medium_mp", "script_vehicle_heli_medium", undefined, "veh9_mil_air_heli_medium_mp", "veh9_mil_air_heli_medium_mp");
  scripts\vehicle\blima::main("veh8_mil_air_blima", "lbravo_infil_cp", "script_vehicle_iw8_blima");
  _id_4BEC22BA9253C63C::main("veh9_mil_lnd_jltv_turret_vehphys_mp", "veh9_jltv_physics_sp", "script_vehicle_iw9_jltv_turret_physics");
}

setup_create_script() {
  scripts\common\create_script_utility::register_create_script_arrays("cp_lone_create_script", "cp_lone_create_script", level.scripted_spawner_func.size, _id_615A55DECEA8C8AE::main);
  scripts\common\create_script_utility::register_create_script_arrays("cp_lone_spawners_cs", "cp_lone_spawners_cs", level.scripted_spawner_func.size, _id_730F4DDA66AE1818::main);
  scripts\common\create_script_utility::register_create_script_arrays("cp_lone_systems_cs", "cp_lone_systems_cs", level.scripted_spawner_func.size, _id_7D0AE34BDC72DBC3::main);
  scripts\common\create_script_utility::register_create_script_arrays("cp_lone_defend_spawners_heli_cs", "cp_lone_defend_spawners_heli_cs", level.scripted_spawner_func.size, _id_6D9D7B36EB027E38::main);
  scripts\common\create_script_utility::register_create_script_arrays("cp_lone_intro_cs", "cp_lone_intro_cs", level.scripted_spawner_func.size, _id_49F3320AFE37E16C::main);
}

_id_FC4803DC319A81D2() {
  level thread wait_for_pre_game_period();
  level thread wait_for_strike_init_complete();
}

wait_for_pre_game_period() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("bsp_structs_initialized");
  scripts\engine\utility::flag_wait("level_ready_for_script");
}

wait_for_strike_init_complete() {
  level endon("game_ended");

  if(scripts\engine\utility::flag_exist("strike_init_done"))
    scripts\engine\utility::flag_wait("strike_init_done");

  wait 1;
  level thread scripts\cp\intel\cp_intel::_id_4F08AFA61F734625();
}

_id_C2A86F682BF1AB71() {
  level.objectives_table = "cp/cp_lone_objectives.csv";
  level.objectivesmatrixtable = "cp/cp_lone_objectives_matrix.csv";
  level.objectiveregistration = ::_id_77765E5DD4C9DB54;
  scripts\cp\cp_objectives::parseobjectivestable(level.objectives_table);
}

_id_77765E5DD4C9DB54() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  scripts\engine\utility::flag_wait("objective_table_parsed");
}

_id_D525F1534752BFC7() {
  scripts\cp\utility::_id_0C72FF775CD61B11("scr_game_enableMinimap", 1, 0);
  setDvar("dvar_9758CEC587280B4A", 1);
  setDvar("dvar_BC802DEB1FF2A842", 1);
  setDvar("dvar_A474FDC25AD6AB13", 0);
  setDvar("dvar_88E213738A43D195", 1);
  setDvar("dvar_C55DC89EF275CDAA", 1);
  setDvar("dvar_B13C2AA9660602C9", 1);
  setDvar("dvar_BF4E690B12A81B75", 0);
  setDvar("dvar_88F99F8AAD71F40D", 0);
  setDvar("dvar_C2FACF64F58F632B", 0);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_EEDC456CB0CCE98F", 1, 0);
  setdvarifuninitialized("dvar_50ACFFBF7373AD3E", 1);
  setdvarifuninitialized("dvar_C502F00D1CEF7073", 0);
  setdvarifuninitialized("dvar_0BC42E1F5B1FF488", 0);
  setdvarifuninitialized("dvar_A1760CE2E3F17F78", 1);
  scripts\cp\utility::_id_0C72FF775CD61B11("dvar_47B7445B595408F7", 1, 0);
  level._id_8FDE5731BB1BA3BB = 1;
  level.suicide_bomber_combat_func = _id_1685E6D8181C932A::suicide_bomber_combat_func;
  level thread _id_1985BEABA5E12B38::_id_5333CDA790154851();
  level thread _id_1685E6D8181C932A::_id_4AD1751DD6EF5881();

  if(!isDefined(level._id_F78FB7634E3797C4))
    level._id_F78FB7634E3797C4 = [];

  setDvar("sm_sunSampleSizeNear", 1.25);
  setDvar("r_umbraMinObjectContribution", 4);
  setDvar("r_umbraAccurateOcclusionThreshold", 2048);
  setDvar("sm_roundRobinPrioritySpotShadows", 8);
  setDvar("sm_spotUpdateLimit", 8);
  setDvar("ui_gametype", "missions");

  if(!isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()))
    setDvar("scr_localeID", 24);

  if(getdvarint("dvar_11F7475AB2848C04", 1) > 0) {
    setdvarifuninitialized("dvar_49A51BE00848D9B8", 1);
    setdvarifuninitialized("scr_player_maxhealth", 100);
  }

  level._id_D49C99AD85354BD6 = 100;

  if(!isDefined(level.vehicle._id_AAB9695C92B0ED96))
    level.vehicle._id_AAB9695C92B0ED96 = [];

  setDvar("dvar_0B6B48EBDAFC846B", 0);
  setDvar("dvar_9496DB3E51FC0703", 0);
  level.starting_currency = 6000;
  level._id_5A94FBA0FF6C999E = 0;
  level.default_player_spawns = "defend_player_start";
  level._id_C33B373241D2B7A4 = 1;
  scripts\engine\utility::flag_set("infil_complete");
}

_id_BE1328457AEBB1BD() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  wait 2;
  scripts\engine\utility::flag_wait("player_spawned_with_loadout");
  origin = (0, 0, 0);

  if(isDefined(level.players) && isDefined(level.players[0]))
    origin = level.players[0].origin - (0, 0, 1000);

  playFX(level.g_effect["human_gib_fullbody"], origin);
  playFX(level.g_effect["vfx_suicide_bomber_gib_explode"], origin);
}

_id_F58E082D627F3645(delay) {
  if(level._id_62F5F42C7C300055 > level._id_70100E2C8547084F) {
    return;
  }
  _id_A02118632C7F1621 = scripts\engine\utility::getStructArray("defender_hardpoint", "script_noteworthy");
  level._id_726A4A2973C34CD4 = [];
  level._id_0C636F650491AE5C = [];
  level._id_671D9F52D923F36E = [];
  level._id_FECE02A99189C2DE = [];
  [_id_189B0BD812D4111B, _id_50982862CFBCE565] = _id_73E75E5FB95D1CB7();
  _id_4B57F37451FFE58F = level._id_215CD837F06FA79E._id_69714C701D381A31[level._id_62F5F42C7C300055];
  _id_6481A5603EF00ABB = min(_id_4B57F37451FFE58F, _id_189B0BD812D4111B.size);
  _id_B0DEB10ED5BF7BE8 = -1;

  if(_id_6481A5603EF00ABB > 1)
    level._id_B088D0265F50FE7A = undefined;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6481A5603EF00ABB; _id_AC0E594AC96AA3A8++) {
    _id_189B0BD812D4111B = _id_846AC21FF614B639(_id_189B0BD812D4111B, _id_50982862CFBCE565);

    if(isDefined(level._id_F168838CCB5AE29E) && level._id_F168838CCB5AE29E.size > 0) {
      _id_B0DEB10ED5BF7BE8 = scripts\engine\utility::random(level._id_F168838CCB5AE29E);
      _id_189B0BD812D4111B = scripts\engine\utility::array_remove(_id_189B0BD812D4111B, _id_B0DEB10ED5BF7BE8);
      level._id_F168838CCB5AE29E = scripts\engine\utility::array_remove(level._id_F168838CCB5AE29E, _id_B0DEB10ED5BF7BE8);
    } else {
      _id_B0DEB10ED5BF7BE8 = scripts\engine\utility::random(_id_189B0BD812D4111B);
      _id_189B0BD812D4111B = scripts\engine\utility::array_remove(_id_189B0BD812D4111B, _id_B0DEB10ED5BF7BE8);
    }

    if(_id_6481A5603EF00ABB == 1)
      level._id_B088D0265F50FE7A = _id_B0DEB10ED5BF7BE8;

    level thread _id_3E19322333AD204C::_id_A82101086E655FDF(_id_A02118632C7F1621[_id_B0DEB10ED5BF7BE8], delay);
  }

  level._id_F168838CCB5AE29E = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_189B0BD812D4111B.size; _id_AC0E594AC96AA3A8++)
    level._id_F168838CCB5AE29E[_id_AC0E594AC96AA3A8] = _id_189B0BD812D4111B[_id_AC0E594AC96AA3A8];
}

_id_73E75E5FB95D1CB7() {
  _id_189B0BD812D4111B = [0, 1, 2, 3, 4];
  _id_50982862CFBCE565 = undefined;
  return [_id_189B0BD812D4111B, _id_50982862CFBCE565];
}

_id_846AC21FF614B639(_id_189B0BD812D4111B, _id_50982862CFBCE565) {
  if(isDefined(level._id_B088D0265F50FE7A) && !isDefined(_id_50982862CFBCE565))
    _id_189B0BD812D4111B = scripts\engine\utility::array_remove(_id_189B0BD812D4111B, level._id_B088D0265F50FE7A);

  return _id_189B0BD812D4111B;
}

_id_91E328822ACF8E4B(_id_62F5F42C7C300055) {
  if(getdvarint("dvar_88F99F8AAD71F40D", 0))
    _id_62F5F42C7C300055 = getdvarint("dvar_88F99F8AAD71F40D");

  if(isDefined(level._id_1CBC4B8EA6561585) && level._id_1CBC4B8EA6561585.size > 0) {
    _id_DB06BA5FB0C46867 = level._id_1CBC4B8EA6561585;
    _id_7BBDA18A855C7111 = _id_DB06BA5FB0C46867;
  } else {
    _id_DB06BA5FB0C46867 = level._id_215CD837F06FA79E._id_DEF74253F2C565A1[_id_62F5F42C7C300055];
    _id_7ABC46D712A21B32 = _id_7A535BB1295D72FB(_id_62F5F42C7C300055);
    _id_7BBDA18A855C7111 = scripts\engine\utility::array_combine(_id_DB06BA5FB0C46867, _id_7ABC46D712A21B32);
  }

  return _id_7BBDA18A855C7111;
}

_id_7A535BB1295D72FB(_id_62F5F42C7C300055) {
  if(isDefined(level._id_215CD837F06FA79E._id_94E26D3F1E7B9449[self.targetname]) && isDefined(level._id_215CD837F06FA79E._id_94E26D3F1E7B9449[self.targetname][_id_62F5F42C7C300055]))
    return level._id_215CD837F06FA79E._id_94E26D3F1E7B9449[self.targetname][_id_62F5F42C7C300055];
  else
    return [];
}

_id_1C616353D73DC331() {
  label = undefined;
  self._id_768859ECE1925E5F = "icon_waypoint_dom_a";

  switch (self.targetname) {
    case "point_a":
      self._id_768859ECE1925E5F = "icon_waypoint_dom_a";
      label = &"CP_MISSION_DEFENDER/HARDPOINT_LABEL_A_LONE";
      break;
    case "point_b":
      self._id_768859ECE1925E5F = "icon_waypoint_dom_b";
      label = &"CP_MISSION_DEFENDER/HARDPOINT_LABEL_B_LONE";
      break;
    case "point_c":
      self._id_768859ECE1925E5F = "icon_waypoint_dom_c";
      label = &"CP_MISSION_DEFENDER/HARDPOINT_LABEL_C_LONE";
      break;
    case "point_d":
      self._id_768859ECE1925E5F = "icon_waypoint_dom_d";
      label = &"CP_MISSION_DEFENDER/HARDPOINT_LABEL_D_LONE";
      break;
    case "point_e":
      self._id_768859ECE1925E5F = "icon_waypoint_dom_e";
      label = &"CP_MISSION_DEFENDER/HARDPOINT_LABEL_E_LONE";
      break;
  }

  return label;
}

_id_B29F7CB5173B7D78(guys) {
  level endon("game_ended");
  level endon("defender_wave_fail");
  level endon("defender_wave_win");
  _id_63429D61D120D4C2 = 0;
  _id_B12025DBD33FD672 = 0;
  maxdist = 4000;

  while(guys.size > 0) {
    guys = scripts\engine\utility::array_removedead_or_dying(guys);

    if(guys.size == 0) {
      break;
    }

    if(guys.size <= 3) {
      _id_63429D61D120D4C2++;
      _id_B12025DBD33FD672++;
    }

    if(_id_B12025DBD33FD672 > 30)
      maxdist = 3000;

    if(_id_63429D61D120D4C2 > 5) {
      _id_ADDD38BB488192B4 = scripts\cp\utility::get_average_origin(level.players);
      _id_AA96A05C93CB3459 = scripts\cp\utility::getfarthest(_id_ADDD38BB488192B4, guys);
      _id_91CF4907C1742793 = 0;

      foreach(player in level.players) {
        _id_91CF4907C1742793 = _id_2B79931B08683E0A::player_can_see_ai(player, _id_AA96A05C93CB3459);

        if(_id_91CF4907C1742793) {
          break;
        }

        _id_91CF4907C1742793 = _id_AA96A05C93CB3459 hastacvis(_id_AA96A05C93CB3459.origin, player.origin, 1);

        if(_id_91CF4907C1742793) {
          break;
        }

        _id_91CF4907C1742793 = _id_AA96A05C93CB3459 seerecently(player, 15);

        if(_id_91CF4907C1742793) {
          break;
        }
      }

      isonturret = _id_AA96A05C93CB3459 _id_3E19322333AD204C::_id_96A4544BE1843F0E();

      if(isonturret) {
        _id_AA96A05C93CB3459.vehicle.unload_group = "all";
        _id_AA96A05C93CB3459.vehicle scripts\common\vehicle_code::_vehicle_unload(_id_AA96A05C93CB3459);
      }

      _id_A728BFBB35592F21 = istrue(_id_AA96A05C93CB3459._id_389B04AEB955FCB9);
      _id_1D24D18E8F904D2D = istrue(_id_AA96A05C93CB3459._id_456F1227DDA72419);
      _id_34395DF55388B808 = isDefined(_id_AA96A05C93CB3459.vehicle) && isDefined(_id_AA96A05C93CB3459.vehicle_position);

      if(!_id_91CF4907C1742793 && !isonturret && !_id_A728BFBB35592F21 && !_id_1D24D18E8F904D2D && !_id_34395DF55388B808 && distance(_id_AA96A05C93CB3459.origin, _id_ADDD38BB488192B4) >= maxdist)
        _id_AA96A05C93CB3459 dodamage(_id_AA96A05C93CB3459.health + 1000, _id_AA96A05C93CB3459.origin);

      _id_63429D61D120D4C2 = 0;
    }

    wait 1;
  }
}

_id_B861150CAE6905B5(_id_B66867E429746D01, _id_DF93C9AA28057B53, _id_8135D794A0D80992) {
  r = 1;

  if(isDefined(_id_B66867E429746D01))
    r = _id_B66867E429746D01[0];

  g = 1;

  if(isDefined(_id_B66867E429746D01))
    g = _id_B66867E429746D01[1];

  b = 1;

  if(isDefined(_id_B66867E429746D01))
    b = _id_B66867E429746D01[2];

  height = scripts\engine\utility::ter_op(isDefined(_id_DF93C9AA28057B53), _id_DF93C9AA28057B53, 1024);
  duration = scripts\engine\utility::ter_op(isDefined(_id_8135D794A0D80992), _id_8135D794A0D80992, 60);
  thread scripts\engine\utility::draw_line_for_time(self.origin, self.origin + (0, 0, height), r, g, b, duration);
}

_id_A654C6DED67DA339(_id_C00448D30DF1BEA6) {
  level endon("game_ended");
  _id_CFF4CD4D39602AAE = scripts\engine\utility::getStructArray(self.target, "targetname");
  _id_FDC11BA76911059E = scripts\engine\utility::array_randomize(_id_CFF4CD4D39602AAE);
  _id_0C3EA9B1A20FF199 = undefined;

  foreach(_id_414EEC2F131C45C0 in _id_FDC11BA76911059E) {
    if(!istrue(_id_414EEC2F131C45C0.in_use)) {
      _id_0C3EA9B1A20FF199 = _id_414EEC2F131C45C0;
      break;
    }
  }

  if(!isDefined(_id_0C3EA9B1A20FF199)) {
    return;
  }
  trig = spawn("trigger_radius", self.origin, 0, int(self.radius), 1024);

  if(!isDefined(trig.radius))
    trig.radius = int(self.radius);

  _id_C718C3FCABAA752F = scripts\engine\utility::drop_to_ground(_id_0C3EA9B1A20FF199.origin);
  _id_92753DA39919F200 = spawn("script_model", _id_C718C3FCABAA752F);
  _id_92753DA39919F200.angles = _id_0C3EA9B1A20FF199.angles;
  _id_92753DA39919F200 setModel("misc_wm_mortar");
  _id_92753DA39919F200.script_noteworthy = "mortar";

  if(!isDefined(level._id_2B218E6AEBB46057))
    level._id_2B218E6AEBB46057 = [];

  level._id_2B218E6AEBB46057[level._id_2B218E6AEBB46057.size] = _id_92753DA39919F200;
  level thread _id_1685E6D8181C932A::_id_5DBE8C6B21E034B4(_id_0C3EA9B1A20FF199.origin, _id_92753DA39919F200);
  spawnpoints = scripts\engine\utility::getStructArray("soldiers_mortarteam", "targetname");
  spawnpoint = scripts\engine\utility::getclosest(_id_0C3EA9B1A20FF199.origin, spawnpoints);
  aitype = "actor_enemy_cp_ar_tier3_cartel";

  if(!isDefined(spawnpoint)) {
    return;
  }
  guys = [];
  guys[guys.size] = spawnpoint _id_18A73A64992DD07D::spawn_ai();
  guys[guys.size] = spawnpoint _id_18A73A64992DD07D::spawn_ai();

  foreach(guy in guys) {
    if(!isDefined(guy)) {
      continue;
    }
    guy._id_389B04AEB955FCB9 = 1;

    if(!isDefined(_id_92753DA39919F200.operator))
      _id_92753DA39919F200.operator = guy;
    else {
      guy setgoalpos(_id_92753DA39919F200.origin);
      guy setgoalentity(_id_92753DA39919F200);
    }

    guy.entered_combat = 1;
  }

  _id_0C3EA9B1A20FF199.in_use = 1;
  level thread _id_230D6EEBDA212CCF(_id_92753DA39919F200, trig);
  level thread _id_1685E6D8181C932A::_id_86F1137F72C8347D(_id_92753DA39919F200);
  level _id_1685E6D8181C932A::_id_3CD7FAF667114025(guys, _id_92753DA39919F200);
  _id_0C3EA9B1A20FF199.in_use = undefined;
  _id_92753DA39919F200.dead = 1;

  foreach(guy in guys) {
    if(isDefined(guy) && isalive(guy))
      guy._id_389B04AEB955FCB9 = undefined;
  }

  _id_92753DA39919F200 notify("stop_mortar_think");
  _id_92753DA39919F200 notify("stop_attracting");
  wait 3;
  _id_92753DA39919F200 playSound("sentry_explode");

  foreach(guy in guys) {
    if(isDefined(guy) && isalive(guy)) {
      _id_BF957E58D9E127A7 = _id_C00448D30DF1BEA6;

      if(isDefined(_id_BF957E58D9E127A7) && isDefined(_id_BF957E58D9E127A7.origin)) {
        guy _id_18A73A64992DD07D::set_goal_radius(450);
        guy _id_18A73A64992DD07D::set_goal_pos(_id_BF957E58D9E127A7.origin);
        guy.goalheight = 48;
        guy.script_origin_other = _id_BF957E58D9E127A7.origin;
        guy.ignoreall = 0;
      }

      if(istrue(guy.dontkilloff))
        guy.dontkilloff = undefined;
    }
  }

  if(_id_92753DA39919F200 tagexists("tag_origin"))
    playFXOnTag(scripts\engine\utility::getfx("sentry_explode_mp"), _id_92753DA39919F200, "tag_origin");

  if(_id_92753DA39919F200 tagexists("tag_aim"))
    playFXOnTag(scripts\engine\utility::getfx("sentry_smoke_mp"), _id_92753DA39919F200, "tag_aim");

  wait 1;
  level._id_2B218E6AEBB46057 = scripts\engine\utility::array_remove(level._id_2B218E6AEBB46057, _id_92753DA39919F200);
  _id_92753DA39919F200 delete();
}

_id_230D6EEBDA212CCF(_id_92753DA39919F200, trig) {
  _id_92753DA39919F200 endon("stop_mortar_think");
  _id_92753DA39919F200.targets = undefined;

  for(;;) {
    _id_92753DA39919F200.targets = _id_9CB5E0B04644DD1A(trig);

    if(isDefined(_id_92753DA39919F200.targets) && _id_92753DA39919F200.targets.size > 0) {
      _id_504283B70DE854FA::attract_agent_to_mortar(_id_92753DA39919F200, 1, 1024);
      wait 3;
      continue;
    }

    wait 1;
  }
}

_id_9CB5E0B04644DD1A(trig) {
  players = scripts\common\utility::_id_0A92D0739B2373DF(trig.origin, trig.radius, 1);
  validplayers = [];

  foreach(player in players) {
    if(!player scripts\cp\utility::is_valid_player() || !player isonground() || player isonladder()) {
      continue;
    }
    validplayers[validplayers.size] = player;
  }

  return validplayers;
}

_id_F76C8BF80E927543(_id_800676BBD5453FC0, type) {
  level endon("game_ended");

  if(!isDefined(_id_800676BBD5453FC0) || !isDefined(_id_800676BBD5453FC0._id_57F8B4C321038A32)) {
    return;
  }
  _id_800676BBD5453FC0 thread _id_3E19322333AD204C::_id_96BBAAC35A60C43C("group_spawning_completed");
  level._id_215CD837F06FA79E._id_1F44055D8DF16E0B++;

  if(_id_800676BBD5453FC0._id_57F8B4C321038A32 == "juggernaut") {
    _id_3E19322333AD204C::_id_20EDD29C5EC08E09(type);
    level thread _id_48F20B0FE71DD6DF::_id_A2B9761A329063EE(_id_800676BBD5453FC0._id_3E2A73CF57C32C7C);
  } else if(_id_800676BBD5453FC0._id_57F8B4C321038A32 == "truck") {
    level thread _id_3E19322333AD204C::_id_A6CAE4648AAFCD7B(_id_800676BBD5453FC0._id_79F102B3ABCC6F8A[0], _id_800676BBD5453FC0);
    level thread _id_3E19322333AD204C::_id_ED3FEFEBBF3E58AD(_id_800676BBD5453FC0);
    return;
  } else if(_id_800676BBD5453FC0._id_57F8B4C321038A32 == "turret") {
    level thread _id_3E19322333AD204C::_id_A6CAE4648AAFCD7B(_id_800676BBD5453FC0._id_79F102B3ABCC6F8A[0], _id_800676BBD5453FC0);
    level thread _id_3E19322333AD204C::_id_ED3FEFEBBF3E58AD(_id_800676BBD5453FC0);
    return;
  } else if(_id_800676BBD5453FC0._id_57F8B4C321038A32 == "bomber_small" || _id_800676BBD5453FC0._id_57F8B4C321038A32 == "bomber_medium" || _id_800676BBD5453FC0._id_57F8B4C321038A32 == "bomber_large")
    level thread _id_48F20B0FE71DD6DF::_id_B52DDE30EF712E97(_id_800676BBD5453FC0);
  else if(_id_800676BBD5453FC0._id_57F8B4C321038A32 == "riotshield")
    level thread _id_48F20B0FE71DD6DF::_id_E492A31537903303(_id_800676BBD5453FC0);
  else if(_id_800676BBD5453FC0._id_57F8B4C321038A32 == "mortar") {
    id = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_800676BBD5453FC0._id_2444B7785351D927);
    level thread _id_48F20B0FE71DD6DF::_id_DBFD1C084C4A1365(_id_800676BBD5453FC0);
    level thread _id_1685E6D8181C932A::_id_CC07567B08D95292("mortar_area_hardpoint_" + id, _id_800676BBD5453FC0._id_2444B7785351D927);
    level thread _id_3E19322333AD204C::_id_ED3FEFEBBF3E58AD(_id_800676BBD5453FC0);
    return;
  } else if(_id_800676BBD5453FC0._id_57F8B4C321038A32 == "heli_heavy") {
    if(!isDefined(level._id_8F9CA681A5D5F7E6) || !istrue(level._id_8F9CA681A5D5F7E6)) {
      level._id_8F9CA681A5D5F7E6 = 1;
      level._id_11A368973DB314CA = _id_7AF29C0D11278DBA::_id_9C5F65BACCB9CCEC();
    }

    return;
  }

  if(istrue(_id_800676BBD5453FC0.isheli)) {
    spawn_point = _id_1685E6D8181C932A::_id_2E1F95D1B1F30D30(_id_800676BBD5453FC0);

    if(isDefined(spawn_point)) {
      spawn_point._id_14CDE247AC3313A4 = "black";
      heli = scripts\cp\cp_spawning_util::_id_94E3A9862B435632(spawn_point);
      heli thread _id_1685E6D8181C932A::_id_21E835AC16584AEC(_id_800676BBD5453FC0);
      heli.team = "axis";
      heli scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(heli);
      level thread _id_3E19322333AD204C::_id_ED3FEFEBBF3E58AD(_id_800676BBD5453FC0);
    }

    return;
  }

  if(isDefined(_id_800676BBD5453FC0.script_noteworthy))
    _id_1685E6D8181C932A::_id_1C9666BEF6857EF4(_id_800676BBD5453FC0);

  _id_F318D96DABD3B489 = _id_18A73A64992DD07D::run_spawn_module(_id_800676BBD5453FC0._id_3E2A73CF57C32C7C);
  _id_800676BBD5453FC0._id_F318D96DABD3B489 = _id_F318D96DABD3B489;
  level thread _id_3E19322333AD204C::_id_ED3FEFEBBF3E58AD(_id_800676BBD5453FC0);
}

_id_BAFFF60BC18C500C() {
  level._id_6664BAC2A45BC0A0 = [];
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_CHAVEZ";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_DIAZ";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_ESTRADA";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_GARCIA";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_GOMEZ";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_GONZALEZ";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_HERNANDEZ";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_LOPEZ";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_MACHADO";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_MARTINEZ";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_MONTOYA";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_NAVARRO";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_PEREZ";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_RAMIREZ";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_RODRIQUEZ";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_SANCHEZ";
  level._id_6664BAC2A45BC0A0[level._id_6664BAC2A45BC0A0.size] = &"CP_MISSION_DEFENDER/ALLY_MEX_TORRES";
}

_id_14AD2410A9A3B8EB() {
  level._id_9C3AA643B7642FB1 = &"CP_WEAPON_BUY/DELTA_SQUAD_LONE_ALIVE";
  level._id_87DBB8D8D744C95F = &"CP_WEAPON_BUY/DELTA_SQUAD_LONE_SPAWN";
  level._id_988BC8650B85A175 = &"CP_WEAPON_BUY/DELTA_SQUAD_LONE_PAUSED";
}