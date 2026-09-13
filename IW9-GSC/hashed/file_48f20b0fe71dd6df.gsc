/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_48f20b0fe71dd6df.gsc
***********************************************/

_id_57A2962EB1F07B36() {
  level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_uss1_allstationsthisisdev");
}

_id_E95C395D21DDE751() {
  wait 1.6;
  level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_hlp1_visualontheobservato");
  _id_DA8D8B48A57F1FBF();
  wait 3.5;
  level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_lasw_breaker1primaryobjec");
  _id_DA8D8B48A57F1FBF();
  level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
  wait 1.5;
  _id_DA8D8B48A57F1FBF();
  level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_hlp1_troopsincontactdownt");
}

_id_9F60BD505EAEDDF0() {
  level endon("game_ended");
  wait 0.5;
  level thread _id_239699C5CBD290E9("stat_0CD1D2547E61FB1E");
  wait 0.05;
  level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_hlp1_shitholdon");
  wait 4.25;
  level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_hlp1_devil1weregettinglit");
  level thread _id_FE001D7AAA01F2AC();
  _id_DA8D8B48A57F1FBF();
  level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_uss1_copyfallingbacktoyou");
  _id_DA8D8B48A57F1FBF();
  level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_hlp1_watcher1alphaiscompr");
  wait 1;
  _id_DA8D8B48A57F1FBF();
  level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_lasw_copythat");
  wait 2;
  _id_DA8D8B48A57F1FBF();
  level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_lasw_breaker1linkupwithth_01");
  _id_DA8D8B48A57F1FBF();
  level thread _id_239699C5CBD290E9("stat_D40E9C698C76A57F");
  wait 2;
  _id_DA8D8B48A57F1FBF();
  level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_hlp1_king6touchingdownatt");
  level thread _id_0E52233E5B79805F();
  level waittill("infil_exfil_start");
  wait 0.5;
  _id_DA8D8B48A57F1FBF();
  level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_hlp1_watcher1breakerisont");
  _id_DA8D8B48A57F1FBF();
  wait 1;
  level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_lasw_copythat_01");
  _id_DA8D8B48A57F1FBF();
  wait 2;
  level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_hlp1_king6cominout");
}

_id_0E52233E5B79805F() {
  level endon("game_ended");
  level endon("infil_exfil_start");
  level endon("defender_intro_completed");
  wait 6;

  for(;;) {
    wait 16;
    _id_DA8D8B48A57F1FBF();
    level thread _id_775CD164C569E279("dx_cp_cpob_dfnf_hlp1_chooseyourgearbreake");
  }
}

_id_FE001D7AAA01F2AC() {
  wait 5.7;
  level thread _id_239699C5CBD290E9("stat_C8122B0900BA529D");
  wait 0.05;
}

_id_AA41ADFD5BD54BD0() {
  level endon("game_ended");
  level waittill("defender_intro_play");
  wait 2.5;
  soldier = level.players[0] _id_5BC0F070AA89D04B::_id_222DEBB6FDD28FB7();
  soldier _id_A200749532A76F74("dx_cp_cpob_dfin_uss1_christitsgoodtoseeyo");
}

_id_85B2A3F43E3EB338() {
  soldier = level.players[0] _id_5BC0F070AA89D04B::_id_222DEBB6FDD28FB7();
  soldier _id_A200749532A76F74("dx_cp_cpob_dfin_uss1_aqwantsthoseweaponin");
  wait 4;
  soldier _id_A200749532A76F74("dx_cp_cpob_dfin_uss1_takeanysuppliesyoune");
  wait 2;
  _id_DA8D8B48A57F1FBF();
  level thread _id_239699C5CBD290E9("stat_0098D27593A2C430");
}

_id_9121843B830CD3E4() {
  level endon("game_ended");
  level endon("defender_intro_completed");
  level waittill("defender_bomb_planted");
  wait 0.25;
  soldier = level.players[0] _id_5BC0F070AA89D04B::_id_222DEBB6FDD28FB7();

  if(isDefined(soldier)) {
    if(scripts\engine\utility::cointoss())
      soldier _id_A200749532A76F74("dx_cp_cpob_dfin_uss1_enemybombonalpha");
    else
      soldier _id_A200749532A76F74("dx_cp_cpob_dfin_uss1_enemysetachargeonalp");

    level thread _id_D6DDC3899E4F6B08(soldier);
  }

  wait 1;

  if(scripts\engine\utility::cointoss())
    level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_aqistargetingthemuni");
  else
    level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_thisiswatcher1defusa");

  _id_278BA2944DB8A0EA = _id_3E19322333AD204C::_id_A74D0CFDC9AF0414("a");
  _id_93D304CA8B1BD15B = "defender_defuse_" + _id_278BA2944DB8A0EA.targetname;
  msg = level scripts\engine\utility::waittill_any_return_2(_id_93D304CA8B1BD15B, "defender_wave_fail");

  if(msg == _id_93D304CA8B1BD15B) {
    level thread _id_239699C5CBD290E9("stat_E3F99728BEC3CCAD");
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_watcher1copiesall", 1.75);
  } else
    level thread _id_5118F876A195E8AE("a");
}

_id_D6DDC3899E4F6B08(soldier) {
  wait 3;
  _id_DA8D8B48A57F1FBF();

  if(!isalive(soldier)) {
    return;
  }
  soldier _id_A200749532A76F74("dx_cp_cpob_dfin_uss1_copywatcher");
}

_id_DE641834E3B74898(soldier) {
  if(!isDefined(level._id_DE641834E3B74898)) {
    level._id_DE641834E3B74898 = 1;
    wait 1;

    if(isalive(soldier))
      soldier _id_A200749532A76F74("dx_cp_cpob_dfin_uss1_devil1onme");
  } else {
    wait(2 + randomfloat(1));

    if(isalive(soldier) && level._id_DE641834E3B74898 == 1) {
      soldier _id_A200749532A76F74("dx_cp_cpob_dfin_uss2_rog");
      level._id_DE641834E3B74898 = 2;
    } else if(isalive(soldier) && level._id_DE641834E3B74898 > 1)
      soldier thread _id_107A3DC15AFB78BD();
  }
}

_id_4F12585AE2E9B952(soldier) {
  level endon("timeout_wave");
  level endon("defender_wave_started");
  level endon("defender_intro_completed");
  level endon("deltaSquad_introEngage");
  soldier endon("death");

  if(istrue(level._id_4F12585AE2E9B952)) {
    return;
  }
  level._id_4F12585AE2E9B952 = 1;
  _id_CDC5DD6C28C9709D = squared(800);
  _id_91AE7188F4C06C96 = 0;
  _id_6794F7417ED0B5A2 = 0;
  _id_8699C63FABD688F2 = 1;

  while(!istrue(level._id_E961004A63D606FD)) {
    _id_91AE7188F4C06C96 = _id_91AE7188F4C06C96 + 0.1;

    if(_id_91AE7188F4C06C96 > _id_8699C63FABD688F2 && !scripts\cp\utility::any_player_nearby(soldier.origin, _id_CDC5DD6C28C9709D)) {
      if(_id_6794F7417ED0B5A2 == 0)
        soldier _id_A200749532A76F74("dx_cp_cpob_dfin_uss1_breaker1devil1aqisca");
      else if(_id_6794F7417ED0B5A2 == 1)
        soldier _id_A200749532A76F74("dx_cp_cpob_dfin_uss1_breaker1wecoulduseyo");
      else
        soldier _id_A200749532A76F74("dx_cp_cpob_dfin_uss1_breaker1wereholdingf");

      level thread _id_239699C5CBD290E9("stat_D40E9C698C76A57F", undefined, undefined, 3);
      _id_6794F7417ED0B5A2++;

      if(_id_6794F7417ED0B5A2 > 2)
        _id_6794F7417ED0B5A2 = 0;

      _id_91AE7188F4C06C96 = 0;
      _id_8699C63FABD688F2 = 22;
    }

    wait 0.1;
  }
}

_id_455F8E627F5B3E04(soldier) {
  type = 1;

  if(!isDefined(level._id_455F8E627F5B3E04)) {
    level._id_455F8E627F5B3E04 = 1;
    type = 2;
  }

  wait 1.5;

  if(isalive(soldier)) {
    if(type == 1) {
      soldier _id_A200749532A76F74("dx_cp_cpob_dfin_uss1_copypushingup");
      soldier thread _id_86EB3BF925D63661();
    } else
      soldier _id_A200749532A76F74("dx_cp_cpob_dfin_uss2_moving");
  }
}

_id_291028C58B2B41F3(soldier) {
  soldier endon("intro_infilDeltaSquadWait");
  soldier endon("death");
  wait 2;
  _id_DA8D8B48A57F1FBF();
  soldier _id_A200749532A76F74("dx_cp_cpob_dfin_uss1_breaker1wereholdingf");
}

_id_86EB3BF925D63661() {
  self endon("death");
  wait 2;
  scripts\engine\utility::waittill_any_timeout_2(10, "damage", "bulletwhizby");
  _id_A200749532A76F74("dx_cp_cpob_dfin_uss2_contact");
}

_id_33C82CAE6F347302() {
  level endon("defender_intro_completed");

  if(istrue(level._id_C78BC25CEE6F119C)) {
    wait 2;
    _id_DA8D8B48A57F1FBF();
  }

  _id_278BA2944DB8A0EA = _id_3E19322333AD204C::_id_A74D0CFDC9AF0414("a");
  _id_B006538274BDB38E = scripts\engine\utility::getclosest(_id_278BA2944DB8A0EA.origin, level._id_F78FB7634E3797C4);

  if(isDefined(_id_B006538274BDB38E)) {
    type = randomint(4);

    if(type == 0)
      _id_B006538274BDB38E _id_A200749532A76F74("dx_cp_cpob_dfin_uss1_defusethatbombwellco");
    else if(type == 1)
      _id_B006538274BDB38E _id_A200749532A76F74("dx_cp_cpob_dfin_uss1_getonthatbombwegotyo");
    else if(type == 2)
      _id_B006538274BDB38E _id_A200749532A76F74("dx_cp_cpob_dfin_uss2_wererunningouttatime");
    else if(type == 3)
      _id_B006538274BDB38E _id_A200749532A76F74("dx_cp_cpob_dfin_uss2_breaker1getthatbombd");
  }
}

_id_83DCECF8FCAD91A7(_id_95F23AF9DC5E4813) {
  _id_F259DA5512A72D1E = [];
  _id_CD02FDDAB5D11F9F = [];
  _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfin_uss1_alphasecure");
  _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfin_uss2_alphasecure");
  level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F);

  if(!istrue(_id_95F23AF9DC5E4813))
    level thread _id_239699C5CBD290E9("stat_8545DA6DD67C6763");

  wait 0.5;
  level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_copythat");
  level thread _id_25604608C295B995();
}

_id_25604608C295B995() {
  _id_725EF9CBF47F2896 = scripts\engine\utility::getStruct("intro_ally_target_00_point", "targetname");
  wait 2;
  _id_DA8D8B48A57F1FBF();

  if(!isDefined(level._id_F78FB7634E3797C4) || level._id_F78FB7634E3797C4.size == 0) {
    return;
  }
  foreach(ally in level._id_F78FB7634E3797C4) {
    if(distance(ally.origin, _id_725EF9CBF47F2896.origin) < 500)
      ally._id_A126A8FA27FC3523 = 1;
  }

  _id_278BA2944DB8A0EA = _id_3E19322333AD204C::_id_A74D0CFDC9AF0414("a");
  _id_B006538274BDB38E = scripts\engine\utility::getclosest(_id_278BA2944DB8A0EA.origin, level._id_F78FB7634E3797C4);

  if(isDefined(_id_B006538274BDB38E)) {
    if(scripts\engine\utility::cointoss())
      _id_B006538274BDB38E _id_A200749532A76F74("dx_cp_cpob_dfw1_uss1_devil3thisis11breake");
    else
      _id_B006538274BDB38E _id_A200749532A76F74("dx_cp_cpob_dfw1_uss2_devil3thisis12breake");
  }

  wait 3.5;
  _id_DA8D8B48A57F1FBF();
  type = 1;

  foreach(ally in level._id_F78FB7634E3797C4) {
    if(type >= 3) {
      break;
    }

    if(distance(ally.origin, _id_725EF9CBF47F2896.origin) < 500) {
      if(type == 1)
        ally _id_A200749532A76F74("dx_cp_cpob_dfw1_uss1_31copies");
      else if(type == 2)
        ally _id_A200749532A76F74("dx_cp_cpob_dfw1_uss2_32copies");

      type++;
    }

    wait 1.25;
  }
}

_id_EAD6C8307D2EBF4B(ally) {
  wait 2.5;

  if(!isalive(ally)) {
    return;
  }
  ally _id_A200749532A76F74("dx_cp_cpob_dfw1_uss1_31copies");
}

_id_29BC7E43DFDC6E43() {
  level endon("game_ended");
  level endon("timeout_wave");

  if(level._id_62F5F42C7C300055 == 2) {
    wait 6;
    _id_DA8D8B48A57F1FBF();
    type = randomint(3);

    if(type == 0) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1supportasset");
      return;
    }

    if(type == 1) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1supportasset_01");
      return;
    }

    if(type == 2) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1supportasset_02");
      return;
    }

    return;
    return;
  } else if(level._id_62F5F42C7C300055 == 3) {
    wait 3;
    _id_DA8D8B48A57F1FBF();
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw3_lasw_allstationsaqtargets");
  } else if(level._id_62F5F42C7C300055 == 4) {
    wait 3;
    _id_DA8D8B48A57F1FBF();
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw4_lasw_thisiswatcher1enemym_01");
  } else if(level._id_62F5F42C7C300055 == 5) {
    wait 3;
    _id_DA8D8B48A57F1FBF();
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw5_lasw_thisiswatcher1allvis");
  }
}

_id_D32EEC2E245BB0BA(_id_D834B47AEF782783) {
  _id_91EC10CFA1F47A1E = _id_D834B47AEF782783;

  if(_id_91EC10CFA1F47A1E.size == 0) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender_vo", "few_enemies_remain")) {
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender_vo", "few_enemies_remain")]](_id_91EC10CFA1F47A1E);
    return;
  }

  if(istrue(level._id_21F279867AD3E473)) {
    _id_278BA2944DB8A0EA = _id_3E19322333AD204C::_id_A74D0CFDC9AF0414("a");

    if(istrue(_id_278BA2944DB8A0EA._id_ABEAE1966A23E2E3)) {
      _id_93D304CA8B1BD15B = "defender_defuse_" + _id_278BA2944DB8A0EA.targetname;
      level waittill(_id_93D304CA8B1BD15B);
      wait 3;
      _id_91EC10CFA1F47A1E = scripts\engine\utility::array_removedead(_id_91EC10CFA1F47A1E);

      if(_id_91EC10CFA1F47A1E.size == 0) {
        return;
      }
      level thread _id_FFD2DFF0D5217FD4("a", 1);
    } else
      level thread _id_FFD2DFF0D5217FD4("a");

    wait 3;

    if(scripts\engine\utility::cointoss())
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_breaker1youstillhave");
    else
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_breaker1stillseeinga");

    wait 1.5;
  }

  level thread _id_F00555177C793A69(_id_91EC10CFA1F47A1E);
  wait 1.5;
  level thread _id_8B5038C5C1F2F3D7(_id_91EC10CFA1F47A1E);

  if(!istrue(level._id_21F279867AD3E473)) {
    if(_id_91EC10CFA1F47A1E.size == 0) {
      return;
    }
    _id_2F23A743210AC63A = _id_91EC10CFA1F47A1E[0].origin;
    _id_1586749ED76ACAEC = _id_3E19322333AD204C::_id_9472000B5A2CE4FC(_id_2F23A743210AC63A);

    while(_id_91EC10CFA1F47A1E.size > 1) {
      if(isDefined(_id_91EC10CFA1F47A1E[0]) && isalive(_id_91EC10CFA1F47A1E[0])) {
        _id_2F23A743210AC63A = _id_91EC10CFA1F47A1E[0].origin;
        _id_1586749ED76ACAEC = _id_3E19322333AD204C::_id_9472000B5A2CE4FC(_id_2F23A743210AC63A);
      }

      _id_91EC10CFA1F47A1E = scripts\engine\utility::array_removedead(_id_91EC10CFA1F47A1E);
      wait 0.05;
    }

    _id_D1F853B89055E55C = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_1586749ED76ACAEC);

    while(_id_91EC10CFA1F47A1E.size > 0) {
      _id_91EC10CFA1F47A1E = scripts\engine\utility::array_removedead(_id_91EC10CFA1F47A1E);
      wait 0.05;
    }

    level thread _id_FADF2EDC6F35FDCA(_id_D1F853B89055E55C);
  }
}

_id_F00555177C793A69(guys) {
  guys = scripts\engine\utility::array_removedead(guys);

  if(guys.size == 0) {
    return;
  }
  _id_BFD74BBA4A40DE65 = scripts\cp\utility::get_average_origin(level.players);
  _id_056FDE3AB766B9EA = scripts\cp\utility::get_average_origin(guys);
  dir = _id_B05C1C65784A70B6(_id_BFD74BBA4A40DE65, _id_056FDE3AB766B9EA);

  if(dir == "north") {
    type = randomint(3);

    if(type == 0) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_toyournorth");
      return;
    }

    if(type == 1) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_north");
      return;
    }

    if(type == 2) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_northside");
      return;
    }

    return;
    return;
  } else if(dir == "west") {
    type = randomint(3);

    if(type == 0) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_tothewest");
      return;
    }

    if(type == 1) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_west");
      return;
    }

    if(type == 2) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_checkwest");
      return;
    }

    return;
    return;
  } else if(dir == "south") {
    type = randomint(3);

    if(type == 0) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_tothesouth");
      return;
    }

    if(type == 1) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_south");
      return;
    }

    if(type == 2) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_checksouth");
      return;
    }

    return;
    return;
  } else if(dir == "east") {
    type = randomint(3);

    if(type == 0)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_toyoureast");
    else if(type == 1)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_east");
    else if(type == 2)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_eastside");
  }
}

_id_8B5038C5C1F2F3D7(_id_91EC10CFA1F47A1E) {
  _id_91EC10CFA1F47A1E = scripts\engine\utility::array_removedead(_id_91EC10CFA1F47A1E);

  if(_id_91EC10CFA1F47A1E.size == 0) {
    return;
  }
  if(_id_91EC10CFA1F47A1E.size == 5) {
    type = randomint(3);

    if(type == 0) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_fivemovers");
      return;
    }

    if(type == 1) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_gotfiveofthem");
      return;
    }

    if(type == 2) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_icountfive");
      return;
    }

    return;
    return;
  } else if(_id_91EC10CFA1F47A1E.size == 4) {
    type = randomint(3);

    if(type == 0) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_fourmovers");
      return;
    }

    if(type == 1) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_youhavefourofem");
      return;
    }

    if(type == 2) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_fourtargets");
      return;
    }

    return;
    return;
  } else if(_id_91EC10CFA1F47A1E.size == 3) {
    type = randomint(3);

    if(type == 0) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_threemovers");
      return;
    }

    if(type == 1) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_youhavethreetargets");
      return;
    }

    if(type == 2) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_gotthreeofem");
      return;
    }

    return;
    return;
  } else if(_id_91EC10CFA1F47A1E.size == 2) {
    type = randomint(3);

    if(type == 0) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_twotargets");
      return;
    }

    if(type == 1) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_justtwoofem");
      return;
    }

    if(type == 2) {
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_gottwomovers");
      return;
    }

    return;
    return;
  } else if(_id_91EC10CFA1F47A1E.size == 1) {
    type = randomint(3);

    if(type == 0)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_oneenemy");
    else if(type == 1)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_lasttarget");
    else if(type == 2)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_justoneofem");
  }
}

_id_1747AC0335F930DD() {
  level endon("game_ended");

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender_vo", "enemy_casualties"))
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender_vo", "enemy_casualties")]]();
  else {
    for(guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"); guys.size > 14; guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"))
      wait 0.1;

    type = randomint(3);

    if(type == 0)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_breaker1aqstakinghea");
    else {
      if(type == 1) {
        level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_breaker1aqislosinggr");
        return;
      }

      if(type == 2)
        level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_breaker1aqnumbersare");
    }
  }
}

_id_F1D362485830C36B(id) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender_vo", "bomb_planted")) {
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender_vo", "bomb_planted")]](id);
    return;
  }

  if(istrue(level._id_21F279867AD3E473)) {
    return;
  }
  wait 1.5;
  _id_DA8D8B48A57F1FBF();
  id = tolower(id);
  type = randomint(3);
  _id_F259DA5512A72D1E = [];
  _id_CD02FDDAB5D11F9F = [];

  if(id == "a") {
    if(type == 0)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_breaker1enemybombata");
    else if(type == 1)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_breaker1theenemyplan");
    else if(type == 2)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_breaker1aqsetacharge");

    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss1_enemybombatalpha");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss1_theenemyplantedatalp");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss1_alphaishotenemybomba");
  } else if(id == "b") {
    if(type == 0)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1theenemyseta");
    else if(type == 1)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1enemybombatb");
    else if(type == 2)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1aqplantedatb");

    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_wegotabombonbravo");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_enemysetachargeonbra");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_theresabombonbravo");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_wegotabombonbravo");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_enemysetachargeonbra");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_theresabombonbravo");
  } else if(id == "c") {
    if(type == 0)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1charlieishot");
    else if(type == 1)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1enemybombatc");
    else if(type == 2)
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1aqplantedatc");

    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_enemybombatcharlie");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_theenemyplantedatcha");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_charlieishotenemybom");
  }

  level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F, 1.5);
}

_id_90C10B7C29A8BE21(_id_3DEF217D9BD38E42, player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender_vo", "bomb_defused")) {
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender_vo", "bomb_defused")]](_id_3DEF217D9BD38E42);
    return;
  }

  if(istrue(level._id_21F279867AD3E473)) {
    return;
  }
  id = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_3DEF217D9BD38E42);
  _id_F259DA5512A72D1E = [];
  _id_CD02FDDAB5D11F9F = [];

  if(id == "a") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfin_uss1_alphasecure");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfin_uss2_alphasecure");
  } else if(id == "b") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_bravosecure");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_bombdefused");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_allstationsbombdefus");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_bombdefusedatbravo");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_chargedefused");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_bravosecure");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_allstationsbombdefus");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_bombdefused");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_bombdefusedatbravo");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_chargedefused");
  } else if(id == "c") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_allstationsbombdefus");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_bombdefusedcharliese");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_bombdefusedatcharlie");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_charliesecurecharged");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_allstationsbombdefus");
  }

  level._id_1AD5CCBD7284D977 = gettime();

  if(_id_3DEF217D9BD38E42._id_B26717F6F0C58C41 < 15)
    level thread _id_A9632ED81F365867(player, "stat_122E9B7F62BDB160");
  else
    level thread _id_A9632ED81F365867(player, "stat_A86EE45822E748C6");

  wait 1;
  _id_DA8D8B48A57F1FBF();
  level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F);
  wait 1;
  _id_DA8D8B48A57F1FBF();
  level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_watcher1copiesall");
  wait 4;
  guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  _id_3AAF4BD74BAAD6CF = scripts\engine\utility::getclosest(_id_3DEF217D9BD38E42.origin, guys, 1400);

  if(isDefined(_id_3AAF4BD74BAAD6CF))
    level thread _id_FFD2DFF0D5217FD4(id);
}

_id_5118F876A195E8AE(id) {
  id = tolower(id);
  _id_F259DA5512A72D1E = [];
  _id_CD02FDDAB5D11F9F = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender_vo", "bomb_exploded")) {
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender_vo", "bomb_exploded")]](id);
    return;
  }

  if(id == "a") {
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_allstationstheenemyd");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss1_alphaisdown");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss1_welostalpha");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss2_alphaiscompromised");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss2_theenemydestroyedalp");
  } else if(id == "b") {
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_allstationstheenemyd");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_bravoisdown");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_welostbravo");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_bravoiscompromised");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_theenemydestroyedbra");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_bravoisdown");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_welostbravo");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_bravoiscompromised");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_theenemydestroyedbra");
  } else if(id == "c") {
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_allstationstheenemyd_01");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_charlieisdown");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_welostcharlie");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_charlieiscompromised");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_theenemydestroyedcha");
  } else if(id == "d") {
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_allstationstheenemyd_01");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_charlieisdown");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_welostcharlie");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_charlieiscompromised");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_theenemydestroyedcha");
  } else if(id == "e") {
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_allstationstheenemyd_01");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_charlieisdown");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_welostcharlie");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_charlieiscompromised");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_theenemydestroyedcha");
  }

  level._id_ADFA9C802373792D = id;
  level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F, 0.3);
}

_id_FADF2EDC6F35FDCA(id) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender_vo", "point_clear")) {
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender_vo", "point_clear")]]();
    return;
  }

  level._id_C78BC25CEE6F119C = 1;
  wait 1.2;
  _id_DA8D8B48A57F1FBF();
  _id_F259DA5512A72D1E = [];
  _id_CD02FDDAB5D11F9F = [];

  if(id == "a") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfin_uss1_clear");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfin_uss1_bunkersclear");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfin_uss2_clear");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfin_uss2_bunkersclear");
    level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_breaker1allvisibleth", 4);
  } else if(id == "b") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_bravosclear");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_radarisclear");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_bravosclear");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_radarisclear");
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1bravoisclear", 4);
  } else if(id == "c") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_charliesclear");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_exportareaisclear");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_charliesclear");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_exportareaisclear");
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1allvisibleth", 4);
  }

  level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F);
  wait 4;
  _id_DA8D8B48A57F1FBF();
  level._id_C78BC25CEE6F119C = undefined;
}

_id_FFD2DFF0D5217FD4(id, _id_85A12BC75A62268B) {
  _id_F259DA5512A72D1E = [];
  _id_CD02FDDAB5D11F9F = [];

  if(id == "a") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfin_uss1_aqsstillupclearthebu");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfin_uss1_aqsinthebunkergetits");

    if(istrue(_id_85A12BC75A62268B)) {
      _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss1_thisis11alphadefused");
      _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss1_allstationsalphadisa");
    }

    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfin_uss2_aqsstillhereclearemo");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfin_uss2_aqsinthebunkersecure");

    if(istrue(_id_85A12BC75A62268B)) {
      _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss2_thisis12bombdefusedw");
      _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss2_allstationsalphadisa");
    }
  } else if(id == "b") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_aqsstillupnearbravos");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_westillgotenemyatbra");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_stillhaveenemyatbrav");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_stillgotaqattheradar");
  } else if(id == "c") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_aqstillintheareasecu");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_charlieisstillhotsec");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_aqstillintheareasecu");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_charlieisstillhotsec");
  }

  level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F);
}

_id_6A930459DD799C7D() {
  _id_F259DA5512A72D1E = [];
  _id_CD02FDDAB5D11F9F = [];
  _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_wegottadefusethatbom");
  _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_wedontdefusethatbomb");
  _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_weneedtodefusethatbo");
  _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_weneedthatbombdefuse");
  _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_getthatbombdefusedfa");
  _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_bombisstillhotweneed");
  _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_wegottadefusethatbom");
  _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_wedontdefusethatbomb");
  _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss3_weneedtodefusethatbo");
  _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_getthatbombdefusedfa");
  _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_bombisstillhotweneed");
  _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss4_weneedthatbombdefuse");
  level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F, 2);
}

_id_1E310AB5E401426D(input, _id_3DEF217D9BD38E42) {
  while(istrue(_id_3DEF217D9BD38E42._id_ABEAE1966A23E2E3))
    wait 0.05;

  if(!istrue(_id_3DEF217D9BD38E42._id_ABEAE1966A23E2E3)) {
    return;
  }
  _id_DA8D8B48A57F1FBF();

  if(input == 45) {
    if(scripts\engine\utility::cointoss())
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_breaker1defusethecha");
    else
      level thread _id_775CD164C569E279("dx_cp_cpob_dfin_lasw_breaker1getthatcharg");

    level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_MISSION_DEFENDER/BOMB_TIMER_WARNING_45", "allies", 5);
  } else if(input == 30) {
    level thread _id_6A930459DD799C7D();
    level thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_MISSION_DEFENDER/BOMB_TIMER_WARNING_30", "allies", 5);
  }
}

_id_A9933584A8B9B252(wave_num, _id_D30FA4B84A691E83) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender_vo", "wave_incoming"))
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender_vo", "wave_incoming")]]();
  else if(wave_num == 1) {
    _id_FEB9E1180835B332 = _id_D30FA4B84A691E83 - 30;

    if(_id_FEB9E1180835B332 > 0) {
      if(_id_FEB9E1180835B332 > 5)
        _id_FEB9E1180835B332 = _id_FEB9E1180835B332 - 5;

      wait(_id_FEB9E1180835B332);
    }

    _id_DA8D8B48A57F1FBF();
    _id_FD50720CC5DECFAB = level._id_FECE02A99189C2DE[0];
    id = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_FD50720CC5DECFAB);

    if(id == "b")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_allstationsthreeaqhe");
    else
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_allstationsbeadvised");

    wait 0.1;
    _id_DA8D8B48A57F1FBF();
    level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
    level thread _id_59C5271CACC2EE02(_id_FD50720CC5DECFAB);
    level thread _id_F7DA793D46308077();
  } else if(wave_num == 2) {
    wait 5;
    _id_DA8D8B48A57F1FBF();
    _id_FD50720CC5DECFAB = level._id_FECE02A99189C2DE[0];
    id = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_FD50720CC5DECFAB);

    if(id == "a") {
      if(scripts\engine\utility::cointoss())
        level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_beadvisedmoreaqbirds");
      else
        level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_beadvisedaqreinforce");
    } else if(id == "b") {
      if(scripts\engine\utility::cointoss())
        level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_beadvisedmoreaqbirds_01");
      else
        level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_beadvisedaqreinforce_01");
    } else if(scripts\engine\utility::cointoss())
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_beadvisedmoreaqbirds_02");
    else
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_beadvisedaqreinforce_02");

    _id_DA8D8B48A57F1FBF();
    level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
    level thread _id_59C5261CACC2EBCF(_id_FD50720CC5DECFAB);
    level thread _id_3E8C309ADC7A2F67();
  } else if(wave_num == 3) {
    wait 2;
    _id_DA8D8B48A57F1FBF();

    if(scripts\engine\utility::cointoss())
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw3_lasw_allstationsaqismount");
    else
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw3_lasw_allstationsaqissendi");

    _id_DA8D8B48A57F1FBF();
    wait 0.5;
    level thread _id_239699C5CBD290E9("stat_D40E9C698C76A57F");
    wait 11;
    _id_DA8D8B48A57F1FBF();
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw3_lasw_beadvisedaqforcesare");
    _id_DA8D8B48A57F1FBF();
    wait 1;
    level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
    level thread _id_3E8C309ADC7A2F67();
  } else if(wave_num == 4) {
    wait 3;
    _id_DA8D8B48A57F1FBF();
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw4_lasw_thisiswatcher1enemym");
    _id_DA8D8B48A57F1FBF();
    wait 0.5;
    level thread _id_239699C5CBD290E9("stat_D40E9C698C76A57F");
    wait 11;
    _id_DA8D8B48A57F1FBF();
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw4_lasw_allstationsenemyheli");
    _id_DA8D8B48A57F1FBF();
    wait 1;
    level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
  } else {
    if(wave_num == 5) {
      wait 4;
      _id_DA8D8B48A57F1FBF();
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw5_lasw_allstationsbeadvised");
      _id_DA8D8B48A57F1FBF();
      wait 1;
      level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
      level thread _id_3E8C309ADC7A2F67();
      return;
    }

    if(wave_num == 6) {
      wait 4;
      _id_DA8D8B48A57F1FBF();
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw6_lasw_allstationsaqismount");
      wait 11;
      _id_DA8D8B48A57F1FBF();
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw6_lasw_beadvisedaqforcesinc");
      _id_DA8D8B48A57F1FBF();
      wait 1;
      level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
      level thread _id_3E8C309ADC7A2F67(1);
    }
  }
}

_id_F7DA793D46308077() {
  level endon("game_ended");
  wait 14;
  _id_DA8D8B48A57F1FBF();
  level thread _id_ED56A46E37534278();
  _id_DA8D8B48A57F1FBF();
  wait 4;
  level thread _id_3E8C309ADC7A2F67();
}

_id_ED56A46E37534278() {
  if(!isDefined(level._id_CAEFF2C8F40D3BC3)) {
    level._id_CAEFF2C8F40D3BC3 = ["dx_cp_cpob_dfw1_lasw_allstationsestablish", "dx_cp_cpob_dfw1_lasw_allstationsaqwantsou", "dx_cp_cpob_dfw1_lasw_allstationsholdthepe", "dx_cp_cpob_dfw1_lasw_breaker1ifaqsecurest", "dx_cp_cpob_dfw1_lasw_breaker1holdtheperim", "dx_cp_cpob_dfw1_lasw_allstationsaqissendi", "dx_cp_cpob_dfw1_lasw_breaker1aqwillnotsto", "dx_cp_cpob_dfw1_lasw_breaker1wecannotallo"];
    level._id_CAEFF2C8F40D3BC3 = scripts\engine\utility::create_deck(level._id_CAEFF2C8F40D3BC3, 1, 1);
  }

  type = level._id_CAEFF2C8F40D3BC3 scripts\engine\utility::deck_draw();
  level thread _id_775CD164C569E279(type);
}

_id_3E8C309ADC7A2F67(_id_B418C58ED542D734) {
  scripts\engine\utility::flag_wait("defender_wave_started");
  wait 4;
  type = randomint(9);

  if(type == 0)
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_allstationsaqreinfor");
  else if(type == 1)
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_allstationsenemyforc");
  else if(type == 2)
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_allstationsaqforcesi");
  else if(type == 3)
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_beadvisedaqisenterin");
  else if(type == 4)
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_defendtheweapondepot");
  else if(type == 5)
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_defendthosemunitions");
  else if(type == 6)
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_keepthemclearofthewe");
  else if(type == 7)
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_theyretargetingourmu");
  else if(type == 8)
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_theyretargetingthewe");

  _id_DA8D8B48A57F1FBF();
  wait 1;

  for(guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"); guys.size == 0; guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis"))
    wait 0.1;

  level thread _id_F00555177C793A69(guys);

  if(istrue(_id_B418C58ED542D734))
    level thread _id_D26E97F2D8F8BAB1();
}

_id_59C5271CACC2EE02(_id_FD50720CC5DECFAB) {
  level endon("game_ended");
  level endon("timeout_wave");
  wait 1;
  _id_DA8D8B48A57F1FBF();
  wait 2;
  _id_FD50720CC5DECFAB = level._id_FECE02A99189C2DE[0];
  id = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_FD50720CC5DECFAB);

  if(id == "a")
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_breaker1linkupwithma");
  else if(id == "b")
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1adviseyoures");
  else if(id == "c")
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1adviseyoures_01");

  wait 8;
  _id_278BA2944DB8A0EA = _id_3E19322333AD204C::_id_A74D0CFDC9AF0414("a");
  distsq = 1440000;

  if(scripts\cp\utility::any_player_nearby(_id_278BA2944DB8A0EA.origin, distsq)) {
    _id_F259DA5512A72D1E = [];
    _id_CD02FDDAB5D11F9F = [];

    if(id == "a")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_breaker1movetoalphaa");
    else if(id == "b")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1movetobravoa");
    else if(id == "c")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1movetocharli");

    _id_DA8D8B48A57F1FBF();
    level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
  }

  wait 8;

  if(scripts\cp\utility::any_player_nearby(_id_278BA2944DB8A0EA.origin, distsq)) {
    _id_F259DA5512A72D1E = [];
    _id_CD02FDDAB5D11F9F = [];

    if(id == "b") {
      _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_betterresupplywhiley");
      _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_bunkerssecuregolinku");
      _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_breaker1weregoodhere");
      _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_devil2sgoingtoneedyo");
      _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_betterresupplywhiley");
      _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_bunkerssecuregolinku");
      _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_breaker1weregoodhere");
      _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_devil2sgoingtoneedyo");
    } else if(id == "c") {
      _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_resupplywhileyoucant");
      _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_bunkerssecuregolinku_01");
      _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_breaker1weregoodhere_01");
      _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss1_devil3sgoingtoneedyo");
      _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_resupplywhileyoucant");
      _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_bunkerssecuregolinku_01");
      _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_breaker1weregoodhere_01");
      _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw1_uss2_devil3sgoingtoneedyo");
    }

    level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F, 2);
    _id_DA8D8B48A57F1FBF();
    level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
  }

  wait 8;
  distsq = 2250000;

  if(scripts\cp\utility::any_player_nearby(_id_278BA2944DB8A0EA.origin, distsq)) {
    if(id == "a")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_breaker1youhaveaqapp");
    else if(id == "b")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1youhaveaqapp");
    else if(id == "c")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1youhaveaqapp_01");

    _id_DA8D8B48A57F1FBF();
    level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
  }

  wait 7;

  if(scripts\cp\utility::any_player_nearby(_id_278BA2944DB8A0EA.origin, distsq)) {
    if(id == "a")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_breaker1gettoalphano");
    else if(id == "b")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1gettobravono");
    else if(id == "c")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1gettocharlie");

    _id_DA8D8B48A57F1FBF();
    level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
  }
}

_id_59C5261CACC2EBCF(_id_FD50720CC5DECFAB) {
  level endon("game_ended");
  level endon("timeout_wave");
  wait 1;
  _id_DA8D8B48A57F1FBF();
  wait 2;

  if(!isDefined(level._id_6138A7806100029B)) {
    return;
  }
  _id_FD50720CC5DECFAB = level._id_FECE02A99189C2DE[0];
  id = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_FD50720CC5DECFAB);
  _id_3D5B5A482DFF011F = _id_3E19322333AD204C::_id_DE5BD5987042469C(level._id_6138A7806100029B);
  distsq = 1440000;

  if(!scripts\cp\utility::are_all_players_nearby(_id_FD50720CC5DECFAB.origin, distsq)) {
    if(id == "a")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_breaker1linkupwithma");
    else if(id == "b")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_breaker1linkupwithde");
    else
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_breaker1linkupwithde_01");

    _id_DA8D8B48A57F1FBF();
    level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
  } else {
    wait 5;
    level thread _id_ED56A46E37534278();
  }

  wait 6;

  if(scripts\cp\utility::any_player_nearby(level._id_6138A7806100029B.origin, distsq)) {
    if(isDefined(level._id_6138A7806100029B)) {
      _id_F259DA5512A72D1E = [];
      _id_CD02FDDAB5D11F9F = [];

      if(_id_3D5B5A482DFF011F == "b") {
        _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss3_radarssecurebestgetm");
        _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss3_breaker1allgoodhere");
        _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss3_bravosgoodfornowyous");
        _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss4_radarssecurebestgetm");
        _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss4_breaker1allgoodhere");
        _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss4_bravosgoodfornowyous");
      } else {
        _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss1_thisareassecurebreak");
        _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss1_breaker1weregoodhere");
        _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss1_charliessecurekeepmo");
        _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss2_thisareassecurebreak");
        _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss2_breaker1weregoodhere");
        _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss2_charliessecurekeepmo");
      }

      level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F, 2);
    }
  }

  wait 8;

  if(scripts\cp\utility::any_player_nearby(level._id_6138A7806100029B.origin, distsq)) {
    if(id == "a") {
      if(scripts\engine\utility::cointoss())
        level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_breaker1movetoalphaa");
      else
        level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_breaker1youhaveaqapp");
    } else if(id == "b") {
      if(scripts\engine\utility::cointoss())
        level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1movetobravoa");
      else
        level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1youhaveaqapp");
    } else if(id == "c") {
      if(scripts\engine\utility::cointoss())
        level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1movetocharli");
      else
        level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1youhaveaqapp_01");
    }

    _id_DA8D8B48A57F1FBF();
    level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
  }

  wait 9;

  if(scripts\cp\utility::any_player_nearby(level._id_6138A7806100029B.origin, distsq)) {
    if(id == "a")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_breaker1gettoalphano");
    else if(id == "b")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1gettobravono");
    else if(id == "c")
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1gettocharlie");

    _id_DA8D8B48A57F1FBF();
    level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
  }
}

_id_07E843ECF26B3937() {
  _id_DA8D8B48A57F1FBF();
  level thread _id_775CD164C569E279("dx_cp_cpob_dfw2_lasw_beadvisedaqforcesint");
}

_id_AA2A43AD24DF9485(_id_9949E4AD68B71129) {
  level endon("game_ended");
  self notify("heli_destroyed_battlechatter");
  self endon("heli_destroyed_battlechatter");
  alias = "stat_346DA2A23EA8FCB3";

  if(istrue(_id_9949E4AD68B71129))
    alias = "stat_00ECDCF88F3403A7";

  self waittill("death");

  if(isDefined(self.script_vehicle_selfremove)) {
    return;
  }
  level thread _id_7552756258E83FD6(alias);
}

_id_B52DDE30EF712E97(_id_800676BBD5453FC0) {
  id = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_800676BBD5453FC0._id_2444B7785351D927);
  _id_F259DA5512A72D1E = [];
  _id_CD02FDDAB5D11F9F = [];

  if(id == "a") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw3_uss1_bombvestbackupbackup");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw3_uss1_bombvestwatchout");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw3_uss2_bombvest");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw3_uss2_lookoutbombvest");
  } else if(id == "b") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw3_uss3_bombvestgetback");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw3_uss3_hesgotabombvest");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw3_uss4_thatsabombvest");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw3_uss4_watchoutbombvest");
  } else {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw3_uss1_bombvestbombvest");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw3_uss1_bombvestbackup");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw3_uss2_getbackhesgotabombve");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw3_uss2_watchoutthatsabombve");
  }

  level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F, 4);
}

_id_DBFD1C084C4A1365(_id_800676BBD5453FC0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender_vo", "wave_incoming")) {
    return;
  }
  level endon("game_ended");
  level endon("defender_wave_fail");
  level endon("defender_wave_win");
  _id_91AE7188F4C06C96 = gettime();

  while(!isDefined(level._id_2B218E6AEBB46057) || level._id_2B218E6AEBB46057.size == 0) {
    wait 0.1;

    if(gettime() > _id_91AE7188F4C06C96 + 15000)
      return;
  }

  if(istrue(level._id_F4976EF5BB0F1324))
    wait 1;

  level._id_F4976EF5BB0F1324 = 1;
  _id_70F36B79C5B931F9 = level._id_2B218E6AEBB46057[level._id_2B218E6AEBB46057.size - 1];
  id = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_800676BBD5453FC0._id_2444B7785351D927);
  _id_F259DA5512A72D1E = [];
  _id_CD02FDDAB5D11F9F = [];

  if(id == "a") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss1_incoming");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss1_mortarincoming");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss2_headsup");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss2_mortarswatchout");
  } else if(id == "b") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss3_incoming");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss3_gettocover");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss4_mortar");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss4_mortarincoming");
  } else {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss1_headsup");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss1_wegotincoming");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss2_incomingincoming");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss2_mortar");
  }

  level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F, 4.5);
  wait 1;
  _id_DA8D8B48A57F1FBF();
  _id_BFD74BBA4A40DE65 = scripts\cp\utility::get_average_origin(level.players);

  if(!isDefined(_id_70F36B79C5B931F9.operator)) {
    return;
  }
  _id_D59ED0E8C57E2DEF = _id_70F36B79C5B931F9.operator.origin;
  dir = _id_B05C1C65784A70B6(_id_BFD74BBA4A40DE65, _id_D59ED0E8C57E2DEF);

  if(dir == "north") {
    if(scripts\engine\utility::cointoss())
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw4_lasw_breaker1mortarsincom");
    else
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw4_lasw_mortarincomingnorths");
  } else if(dir == "west") {
    if(scripts\engine\utility::cointoss())
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw4_lasw_breaker1mortarsfromy");
    else
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw4_lasw_mortarincomingwestsi");
  } else if(dir == "south") {
    if(scripts\engine\utility::cointoss())
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw4_lasw_mortarssouthside");
    else
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw4_lasw_mortarincomingfromth");
  } else if(dir == "east") {
    if(scripts\engine\utility::cointoss())
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw4_lasw_youvegotamortarincom");
    else
      level thread _id_775CD164C569E279("dx_cp_cpob_dfw4_lasw_headsupmortarfromthe");
  }
}

_id_E492A31537903303(_id_800676BBD5453FC0) {
  id = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_800676BBD5453FC0._id_2444B7785351D927);
  _id_F259DA5512A72D1E = [];
  _id_CD02FDDAB5D11F9F = [];
  _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss1_aqriotshieldsincomin_01");
  _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss3_theyvegotriotshields");
  _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss4_aqsgotriotshields");

  if(id == "a") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss1_enemyriotsshieldsata");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss1_wegotenemyriotshield");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss2_aqwithriotsshieldsat");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss2_aqsgotriotshieldsata");
  } else if(id == "b") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss3_gotenemyriotshieldsa");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss3_aqshittingbravotheyv");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss4_wegotaqwithriotshiel");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss4_aqsgotriotshieldswen");
  } else {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss1_enemieswithriotshiel");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss1_aqriotshieldsincomin");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss2_riotshieldenemiesare");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw5_uss2_aqriotshieldsarepush");
  }

  level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F, 10);
}

_id_D26E97F2D8F8BAB1() {
  _id_F259DA5512A72D1E = [];
  _id_CD02FDDAB5D11F9F = [];
  _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss1_incoming");
  _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss1_wegotincoming");
  _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss2_headsup");
  _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw4_uss3_incoming");
  level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F, 15);
}

_id_A2B9761A329063EE(_id_E13FCA89BFF24AF3) {
  level endon("game_ended");
  spawned_ai = [];

  while(!isDefined(spawned_ai) || spawned_ai.size == 0) {
    guys = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < guys.size; _id_AC0E594AC96AA3A8++) {
      if(guys[_id_AC0E594AC96AA3A8] scripts\cp\utility::isjuggernaut())
        spawned_ai[spawned_ai.size] = guys[_id_AC0E594AC96AA3A8];
    }

    wait 1;
  }

  _id_FD50720CC5DECFAB = scripts\engine\utility::getclosest(spawned_ai[0].origin, level._id_FECE02A99189C2DE);
  id = _id_3E19322333AD204C::_id_DE5BD5987042469C(_id_FD50720CC5DECFAB);
  level thread _id_BB2EF5E778692F44(id);
  _id_DABF4CF09B2C06CA = undefined;

  while(isalive(spawned_ai[0])) {
    _id_DABF4CF09B2C06CA = spawned_ai[0].origin;
    wait 0.1;
  }

  if(!isDefined(_id_DABF4CF09B2C06CA) && isDefined(spawned_ai[0].origin))
    _id_DABF4CF09B2C06CA = spawned_ai[0].origin;

  level notify("defender_jugg_killed", _id_DABF4CF09B2C06CA);
  struct = spawnStruct();
  struct.origin = _id_DABF4CF09B2C06CA;
  player = struct scripts\cp\utility::get_closest_living_player();

  if(isDefined(player))
    level thread _id_239699C5CBD290E9("stat_3A0F5BB16DF88C43");
}

_id_BB2EF5E778692F44(id, delay) {
  if(isDefined(delay))
    wait(delay);

  _id_F259DA5512A72D1E = [];
  _id_CD02FDDAB5D11F9F = [];
  _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw6_uss2_enemyjuggernautspott_01");
  _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw6_uss2_visualontheenemyjugg_01");

  if(id == "a") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw6_uss1_enemyjuggernautatalp");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw6_uss1_aqjuggernautisnearal");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw6_uss2_gotanenemyjuggernaut");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw6_uss2_enemyjuggernautonalp");
  } else if(id == "b") {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw6_uss3_aqjuggernautatbravo");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw6_uss3_enemyjuggernautatbra");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw6_uss4_aqjuggernautishittin");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw6_uss4_theenemyjuggernautsa");
  } else {
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw6_uss1_enemyjuggernautatcha");
    _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw6_uss1_aqjuggernautsatcharl");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw6_uss2_enemyjuggernautspott");
    _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw6_uss2_visualontheenemyjugg");
  }

  level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F, 5);
}

_id_A3FD2DA53A75B24A() {
  level endon("game_ended");

  for(;;) {
    level waittill("defender_kiosk_juggernaut_purchased", player);
    _id_DA8D8B48A57F1FBF();
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_sghp_thisissender31jugger");
  }
}

_id_A52439669E58CFC6() {
  if(isDefined(level._id_A52439669E58CFC6) && level._id_A52439669E58CFC6 + 3000 > gettime()) {
    return;
  }
  level._id_A52439669E58CFC6 = gettime();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender_vo", "allies_deploy")) {
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender_vo", "allies_deploy")]]();
    level scripts\engine\utility::delaythread(10, _id_5BC0F070AA89D04B::_id_642C414187745491);
    return;
  }

  _id_31A8E29E242B9A1B = 16;
  _id_00AE14C5A8B1B582 = randomint(3);
  _id_DA8D8B48A57F1FBF();

  if(_id_00AE14C5A8B1B582 == 0) {
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_copyorion41isenterin");
    wait(_id_31A8E29E242B9A1B);
    _id_DA8D8B48A57F1FBF();
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_hlp2_thisisorion41troopsd");
  } else if(_id_00AE14C5A8B1B582 == 1) {
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_standbyorion41isdeli");
    wait(_id_31A8E29E242B9A1B);
    _id_DA8D8B48A57F1FBF();
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_hlp2_breaker1orion41reinf");
  } else if(_id_00AE14C5A8B1B582 == 2) {
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_lasw_breaker1copythatorio");
    wait(_id_31A8E29E242B9A1B);
    _id_DA8D8B48A57F1FBF();
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw1_hlp2_thisisorion41alldevi");
  }

  level scripts\engine\utility::delaythread(15, _id_5BC0F070AA89D04B::_id_642C414187745491);
}

_id_2AC057864B3892E8() {
  if(isDefined(level._id_2AC057864B3892E8) && level._id_2AC057864B3892E8 + 45000 > gettime()) {
    return;
  }
  _id_8F296850FBED696D = 2250000;
  _id_5DAE2C18D8E0E29A = scripts\cp\utility::get_closest_living_player(_id_8F296850FBED696D);

  if(isDefined(_id_5DAE2C18D8E0E29A)) {
    if(!_id_2B79931B08683E0A::player_can_see_ai(_id_5DAE2C18D8E0E29A, self)) {
      return;
    }
    level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(_id_5DAE2C18D8E0E29A, "stat_CAFA7AD7442C35D5", undefined, 1);
    level._id_2AC057864B3892E8 = gettime();
  }
}

_id_FFF151C38D29F877() {
  if(istrue(level._id_EFE609BCE901CAA8) && !scripts\engine\utility::flag("infil_over")) {
    return;
  }
  if(_id_5CB623572B271C34::_id_962089C12B654934()) {
    return;
  }
  if(isDefined(level._id_FFF151C38D29F877) && level._id_FFF151C38D29F877 + 5000 > gettime()) {
    return;
  }
  level._id_FFF151C38D29F877 = gettime();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender_vo", "allies_down")) {
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender_vo", "allies_down")]]();
    return;
  }

  if(!isDefined(level._id_48010A0E9DA3105F)) {
    aliases = ["dx_cp_cpob_dfw4_lasw_breaker1yourreinforc", "dx_cp_cpob_dfw4_lasw_breaker1devilreinfor", "dx_cp_cpob_dfw4_lasw_breaker1yourreinforc_01"];
    level._id_48010A0E9DA3105F = scripts\engine\utility::create_deck(aliases);
  }

  alias = level._id_48010A0E9DA3105F scripts\engine\utility::deck_draw();
  wait 2;
  _id_DA8D8B48A57F1FBF();
  level thread _id_775CD164C569E279(alias);
}

_id_00D22B9E567F113A(id) {
  self endon("death");
  _id_DA8D8B48A57F1FBF();
  id = tolower(id);

  if(id == "point_a" || id == "a")
    _id_A200749532A76F74("dx_cp_cpob_dfw2_uss1_breaker1thisisdevil1");
  else if(id == "point_b" || id == "b")
    _id_A200749532A76F74("dx_cp_cpob_dfw1_uss3_breaker1thisisdevil2");
  else if(id == "point_c" || id == "c")
    _id_A200749532A76F74("dx_cp_cpob_dfw1_uss1_breaker1thisisdevil3");
}

_id_107A3DC15AFB78BD() {
  self endon("death");
  _id_3ABBBB7549584332 = _id_5CB623572B271C34::_id_5C6C98E7D15B8D4A(self.owner);

  if(!isDefined(_id_3ABBBB7549584332)) {
    return;
  }
  if(isDefined(level._id_1AD5CCBD7284D977) && level._id_1AD5CCBD7284D977 + 3000 > gettime())
    wait 3;

  _id_DA8D8B48A57F1FBF();
  _id_22806D47B3138E1A = [];
  _id_22806D47B3138E1A[_id_22806D47B3138E1A.size] = "dx_cp_cpob_dfin_uss1_copypushingup";
  _id_22806D47B3138E1A[_id_22806D47B3138E1A.size] = "dx_cp_cpob_dfin_uss2_moving";
  _id_22806D47B3138E1A[_id_22806D47B3138E1A.size] = "dx_cp_cpob_dfw1_uss3_gotyoursix";
  _id_22806D47B3138E1A[_id_22806D47B3138E1A.size] = "dx_cp_cpob_dfw1_uss3_gotyoucovered";
  _id_22806D47B3138E1A[_id_22806D47B3138E1A.size] = "dx_cp_cpob_dfw1_uss4_gotyourback";
  _id_22806D47B3138E1A[_id_22806D47B3138E1A.size] = "dx_cp_cpob_dfw1_uss4_gotyoucovered";

  if(_id_3ABBBB7549584332.size > 1) {
    _id_22806D47B3138E1A[_id_22806D47B3138E1A.size] = "dx_cp_cpob_dfin_uss1_wellcoveryou";
    _id_22806D47B3138E1A[_id_22806D47B3138E1A.size] = "dx_cp_cpob_dfin_uss1_wegotyoucovered";
    _id_22806D47B3138E1A[_id_22806D47B3138E1A.size] = "dx_cp_cpob_dfin_uss2_wegotyourback";
  }

  alias = scripts\engine\utility::random(_id_22806D47B3138E1A);
  _id_A200749532A76F74(alias);
}

_id_A1415CBE65E80B11() {
  _id_F259DA5512A72D1E = [];
  _id_CD02FDDAB5D11F9F = [];
  _id_F259DA5512A72D1E = _id_F259DA5512A72D1E _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss3_breaker1allgoodhere");
  _id_CD02FDDAB5D11F9F = _id_CD02FDDAB5D11F9F _id_5AE71616BA044E2F("dx_cp_cpob_dfw2_uss4_breaker1allgoodhere");
  level thread _id_975FE0EC727C8488(_id_F259DA5512A72D1E, _id_CD02FDDAB5D11F9F);
}

_id_A7C46CE0E21A633A() {
  level thread _id_775CD164C569E279("DX_GUIDEE1655BE5DEB437F80D77E8097BBA535");
}

_id_C63936225A54FFF7() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("defender_vo", "outro")) {
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("defender_vo", "outro")]]();
    return;
  }

  _id_30C5DCD8B800B7C5 = _id_5CB623572B271C34::_id_110F112431C654DC();

  if(_id_30C5DCD8B800B7C5 > 0) {
    level thread _id_A1415CBE65E80B11();
    wait 1;
  }

  if(scripts\engine\utility::cointoss())
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw6_lasw_allstationsthisiswat_01");
  else
    level thread _id_775CD164C569E279("dx_cp_cpob_dfw6_lasw_allstationsthisiswat");

  _id_DA8D8B48A57F1FBF();
  wait 0.5;
  level thread _id_775CD164C569E279("dx_cp_cpob_dfw6_lasw_keepingthoseweaponso");
  _id_DA8D8B48A57F1FBF();
  wait 0.5;
  level thread _id_775CD164C569E279("dx_cp_cpob_dfw6_lasw_exfilplatformisarriv");
  _id_DA8D8B48A57F1FBF();
  wait 0.5;
  level thread _id_239699C5CBD290E9("stat_BCA5E472447F8C73");
}

_id_239699C5CBD290E9(_id_A569449217DEC446, _id_A569439217DEC213, _id_A569429217DEBFE0, delay) {
  if(isDefined(delay))
    wait(delay);

  alias = _id_A569449217DEC446;

  if(isDefined(_id_A569439217DEC213)) {
    if(scripts\engine\utility::cointoss())
      alias = _id_A569439217DEC213;

    if(isDefined(_id_A569429217DEBFE0)) {
      if(scripts\engine\utility::cointoss())
        alias = _id_A569429217DEBFE0;
    }
  }

  _id_DA8D8B48A57F1FBF();

  foreach(player in level.players) {
    if(isPlayer(player))
      level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, alias);

    wait 0.2;
  }
}

_id_7552756258E83FD6(_id_A569449217DEC446, _id_A569439217DEC213, _id_A569429217DEBFE0) {
  alias = _id_A569449217DEC446;

  if(isDefined(_id_A569439217DEC213)) {
    if(scripts\engine\utility::cointoss())
      alias = _id_A569439217DEC213;

    if(isDefined(_id_A569429217DEBFE0)) {
      if(scripts\engine\utility::cointoss())
        alias = _id_A569429217DEBFE0;
    }
  }

  _id_DA8D8B48A57F1FBF();
  player = scripts\engine\utility::random(level.players);
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, alias);
}

_id_A9632ED81F365867(player, alias) {
  _id_DA8D8B48A57F1FBF();
  level thread scripts\cp\cp_player_battlechatter::trysaylocalsound(player, alias);
}

_id_DA8D8B48A57F1FBF() {
  wait 0.05;

  if(istrue(level._id_BFE5BB3BA83502E3))
    scripts\engine\utility::flag_wait("overlord_vo_cleared");

  wait 0.25;

  while(istrue(level.isteamvoplaying))
    wait 0.05;
}

_id_775CD164C569E279(alias, delay) {
  level endon("game_ended");
  alias = tolower(alias);

  if(isDefined(delay))
    wait(delay);

  while(istrue(level._id_7BCA58EBC45C1D47) || istrue(level.isteamvoplaying))
    waitframe();

  level._id_BFE5BB3BA83502E3 = 1;
  level thread _id_E79B052BA77DADE6(alias);
  wait 0.1;

  foreach(player in level.players)
  player.bcdisabled = 1;

  level _id_166B4F052DA169A7::try_to_play_vo_on_team(alias, "allies");

  foreach(player in level.players)
  player.bcdisabled = undefined;

  level._id_BFE5BB3BA83502E3 = 0;
}

_id_E79B052BA77DADE6(alias) {
  if(!scripts\engine\utility::flag_exist("overlord_vo_cleared"))
    scripts\engine\utility::flag_init("overlord_vo_cleared");

  scripts\engine\utility::flag_clear("overlord_vo_cleared");
  _id_4AB28BC6D5AD3D7A = lookupsoundlength(alias) / 1000;
  wait(_id_4AB28BC6D5AD3D7A);
  scripts\engine\utility::flag_set("overlord_vo_cleared");
}

_id_B05C1C65784A70B6(_id_A9F94D266B961E6F, vpoint) {
  angles = vectortoangles(vpoint - _id_A9F94D266B961E6F);
  angle = angles[1];
  northyaw = getnorthyaw();
  angle = angle - northyaw;

  if(angle < 0)
    angle = angle + 360;
  else if(angle > 360)
    angle = angle - 360;

  if(angle < 22.5 || angle > 292.5)
    direction = "north";
  else if(angle < 112.5)
    direction = "west";
  else if(angle < 202.5)
    direction = "south";
  else if(angle < 292.5)
    direction = "east";
  else
    direction = "impossible";

  return direction;
}

_id_593935A9C5193EC7() {
  if(!isDefined(level._id_F78FB7634E3797C4))
    return undefined;

  _id_96D0B6C9E6E45F6B = [];

  foreach(ally in level._id_F78FB7634E3797C4) {
    if(!istrue(ally._id_A126A8FA27FC3523))
      _id_96D0B6C9E6E45F6B[_id_96D0B6C9E6E45F6B.size] = ally;
  }

  _id_C0BF8462A04BE0E9 = [];

  if(_id_96D0B6C9E6E45F6B.size > 0)
    _id_C0BF8462A04BE0E9[_id_C0BF8462A04BE0E9.size] = scripts\engine\utility::getclosest(level.players[0].origin, _id_96D0B6C9E6E45F6B);

  if(level.players.size == 2 && _id_C0BF8462A04BE0E9.size > 0 && _id_96D0B6C9E6E45F6B.size > 0) {
    if(distance(level.players[0].origin, level.players[1].origin) > 2000) {
      _id_A808FFCE94764258 = scripts\engine\utility::getclosest(level.players[1].origin, _id_96D0B6C9E6E45F6B);

      if(isDefined(_id_A808FFCE94764258) && distance(_id_A808FFCE94764258.origin, _id_C0BF8462A04BE0E9[0].origin) > 500)
        _id_C0BF8462A04BE0E9[_id_C0BF8462A04BE0E9.size] = _id_A808FFCE94764258;
    }
  }

  return _id_C0BF8462A04BE0E9;
}

_id_975FE0EC727C8488(_id_4F0531F5C149FEB0, _id_BB4FA1B66CBAD779, delay) {
  _id_8F3F5F128C2E4EE9 = _id_593935A9C5193EC7();

  if(!isDefined(_id_8F3F5F128C2E4EE9)) {
    return;
  }
  if(isDefined(delay))
    wait(delay);

  if(isDefined(_id_8F3F5F128C2E4EE9[0]) && isDefined(_id_4F0531F5C149FEB0) && _id_4F0531F5C149FEB0.size > 0) {
    alias = scripts\engine\utility::random(_id_4F0531F5C149FEB0);
    _id_8F3F5F128C2E4EE9[0] _id_A200749532A76F74(alias);
  }

  if(isDefined(_id_8F3F5F128C2E4EE9[1]) && isDefined(_id_BB4FA1B66CBAD779) && _id_BB4FA1B66CBAD779.size > 0) {
    alias = scripts\engine\utility::random(_id_BB4FA1B66CBAD779);
    wait(1.5 + randomfloat(1));
    _id_8F3F5F128C2E4EE9[1] _id_A200749532A76F74(alias);
  }
}

_id_A200749532A76F74(alias) {
  if(scripts\engine\utility::is_dead_or_dying(self)) {
    return;
  }
  _id_CDC5DD6C28C9709D = squared(600);
  closestplayer = scripts\cp\utility::get_closest_living_player(_id_CDC5DD6C28C9709D);

  if(isDefined(closestplayer))
    self playSound(alias);
  else
    self playcontextsound(alias, "dx_type", "dx_radio_2d");
}

_id_5AE71616BA044E2F(alias) {
  array = self;

  if(isDefined(alias))
    array[array.size] = alias;

  return array;
}